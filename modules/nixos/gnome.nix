{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myModules.nixos.gnome;
in
{
  options.myModules.nixos.gnome = {
    enable = lib.mkEnableOption "GNOME desktop environment";
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
    services.xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];
    };

    environment.systemPackages = with pkgs; [
      gnome-boxes
    ];

    environment.gnome.excludePackages = with pkgs; [
      epiphany
      geary
      gnome-music
      gnome-tour
      yelp
    ];
  };
}
