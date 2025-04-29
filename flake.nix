{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    {
      nixosConfigurations."desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/desktop/configuration.nix ];
      };

      nixosConfigurations."wsl" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/wsl/configuration.nix ];
      };

      nixosConfigurations."proxmox" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/proxmox/configuration.nix ];
      };

      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/macbook/configuration.nix ];
      };

      homeConfigurations."adhoc" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = [ self.overlays.default ];
        };
        modules = [ ./hosts/adhoc/home.nix ];
      };

      overlays.default = import ./overlays { inherit inputs; };

      templates = builtins.listToAttrs (
        map (subdir: {
          name = subdir;
          value = {
            path = ./templates + "/${subdir}";
          };
        }) (builtins.attrNames (builtins.readDir ./templates))
      );
    };
}
