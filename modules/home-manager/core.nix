{ pkgs, repodir, ... }:

{
  programs.home-manager.enable = true;

  nix.registry = {
    nix-config = {
      to = {
        type = "path";
        path = repodir;
      };
    };
  };

  home.packages = with pkgs; [
    gnumake
  ];
}
