{ repodir, ... }:

{
  imports = [
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/gnome.nix
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

  programs.alacritty.settings = {
    font = {
      offset.y = 1;
      size = 12;
    };
    window = {
      dimensions = {
        columns = 248;
        lines = 67;
      };
      padding = {
        x = 12;
        y = 7;
      };
    };
  };
}
