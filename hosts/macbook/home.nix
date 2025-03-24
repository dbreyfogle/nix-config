{ ... }:

{
  imports = [ ../../modules/home-manager/shell.nix ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

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
