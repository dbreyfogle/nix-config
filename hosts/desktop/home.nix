{ pkgs, ... }:

{
  imports = [ ../../modules/home-manager ];

  myModules.home-manager = {
    gnome.enable = true;
    nvidia.enable = true;
    terminal.enable = true;
  };

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    brave
    dbeaver-bin
    discord
    gnome-boxes
    libreoffice
    pika-backup
    portfolio
    slack
    sshfs
    vlc
    vscode
    zoom-us
  ];

  programs = {
    firefox.enable = true;

    ghostty.settings = {
      font-size = 12;
      window-padding-x = "4,0";
      window-padding-y = "11,3";
      window-width = 249;
      window-height = 64;
    };

    obs-studio.enable = true;
  };
}
