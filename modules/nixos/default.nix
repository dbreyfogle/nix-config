{ ... }:

{
  imports = [
    ./gnome.nix
    ./inhibit-sleep-ssh.nix
  ];

  nix = {
    settings.trusted-users = [ "@wheel" ];
  };
}
