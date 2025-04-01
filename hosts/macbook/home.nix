{ repodir, ... }:

{
  imports = [ ../../modules/home-manager/terminal.nix ];

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
      size = 14.5;
    };
    window = {
      padding = {
        x = 10;
        y = 5;
      };
      startup_mode = "Maximized";
    };
  };
}
