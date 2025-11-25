{ pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/core.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/gnome.nix
  ];

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    brave
    dbeaver-bin
    discord
    ghostty
    libreoffice
    obsidian
    pika-backup
    slack
    vlc
    vscode
    zoom-us
  ];

  programs.firefox.enable = true;

  programs.ghostty.settings = {
    font-size = 12;
    window-padding-x = "5,6";
    window-padding-y = "12,3";
    window-width = 249;
    window-height = 64;
  };

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override { config.cudaSupport = true; };
  };
}
