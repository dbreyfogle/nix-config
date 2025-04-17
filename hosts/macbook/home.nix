{ ... }:

{
  imports = [
    ../../modules/home-manager/core.nix
    ../../modules/home-manager/terminal.nix
  ];

  home.stateVersion = "24.11";

  programs.alacritty.settings = {
    font = {
      offset.y = 1;
      size = 15;
    };
    window = {
      option_as_alt = "Both";
      padding = {
        x = 9;
        y = 6;
      };
      startup_mode = "Maximized";
    };
  };
}
