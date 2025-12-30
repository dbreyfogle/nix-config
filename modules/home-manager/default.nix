{ repodir, ... }:

{
  imports = [
    ./gnome.nix
    ./terminal.nix
  ];

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
