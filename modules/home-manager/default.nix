{
  pkgs,
  inputs,
  repodir,
  ...
}:

{
  imports = [
    ./gnome.nix
    ./terminal.nix
  ];

  programs.home-manager.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    registry = {
      nix-config = {
        to = {
          type = "path";
          path = repodir;
        };
      };
    };
    settings = {
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://nixpkgs-terraform.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw="
      ];
    };
  };

  home.packages = with pkgs; [
    gnumake
    nix-tree
  ];
}
