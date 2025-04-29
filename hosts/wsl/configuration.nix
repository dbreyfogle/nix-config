{ pkgs, inputs, ... }:

let
  username = "danny";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-wsl.nixosModules.default
    ../../modules/shared/core.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = username;

  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.self.overlays.default ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      repodir = "/home/${username}/Code/nix-config";
    };
    users.${username} = import ./home.nix;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "Danny Breyfogle";
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  virtualisation.docker.enable = true;
}
