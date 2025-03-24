{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  environment.systemPackages = with pkgs; [
    gnome-boxes
  ];

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    geary
  ];
}
