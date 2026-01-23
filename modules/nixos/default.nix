{ ... }:

{
  imports = [
    ./gnome.nix
    ./inhibit-sleep-ssh.nix
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    optimise = {
      automatic = true;
      dates = "weekly";
    };
    settings.trusted-users = [ "@wheel" ];
  };
}
