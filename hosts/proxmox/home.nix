{ repodir, ... }:

{
  imports = [
    ../../modules/home-manager/terminal.nix
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  nix.registry = {
    nix-config = {
      to = {
        type = "path";
        path = repodir;
      };
    };
  };
}
