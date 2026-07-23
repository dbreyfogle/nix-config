{ pkgs, inputs, ... }:

{
  imports = [
    ./gnome.nix
    ./nvidia.nix
    ./terminal.nix
  ];

  programs.home-manager.enable = true;
  news.display = "silent";

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.numtide.com"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
    };
  };

  home.packages = with pkgs; [
    gnumake
    nix-tree
  ];
}
