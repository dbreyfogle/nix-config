{ pkgs, ... }:

{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
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
}
