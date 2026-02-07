{ lib, pkgs, ... }:

{
  imports = [ ../../modules/home-manager ];

  myModules.home-manager = {
    gnome.enable = true;
    terminal.enable = true;
  };

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    brave
    dbeaver-bin
    discord
    gnome-boxes
    libreoffice
    obsidian
    pika-backup
    protonvpn-gui
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
      maximize = true;
      window-padding-x = "4,0";
      window-padding-y = "10,3";
      window-width = 177;
      window-height = 48;
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ obs-vaapi ];
    };
  };

  dconf.settings = {
    "org/gnome/desktop/session" = {
      idle-delay = lib.gvariant.mkUint32 300;
    };

    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };
}
