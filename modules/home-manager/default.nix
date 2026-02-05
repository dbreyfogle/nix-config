{ pkgs, inputs, ... }:

{
  imports = [
    ./gnome.nix
    ./terminal.nix
  ];

  programs.home-manager.enable = true;
  news.display = "silent";

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  home.packages = with pkgs; [
    gnumake
    nix-tree
  ];
}
