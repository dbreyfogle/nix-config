{ ... }:

{
  imports = [
    ../../modules/home-manager/core.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/gnome.nix
  ];

  home.stateVersion = "24.11";

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

  programs.ghostty.settings = {
    font-size = 12;
    window-padding-x = "5,6";
    window-padding-y = "12,3";
    window-width = 249;
    window-height = 64;
  };
}
