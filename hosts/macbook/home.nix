{ ... }:

{
  imports = [
    ../../modules/home-manager/core.nix
    ../../modules/home-manager/terminal.nix
  ];

  home.stateVersion = "24.11";

  programs.ghostty.settings = {
    font-size = 15;
    window-padding-x = "6,0";
    window-padding-y = "12,4";
  };
}
