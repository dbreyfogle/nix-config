{ ... }:

let
  username = "root";
  homeDirectory = "/root";
  repodir = "/root/nix-config";
in
{
  _module.args.repodir = repodir;

  imports = [
    ../../modules/home-manager/core.nix
    ../../modules/home-manager/terminal.nix
  ];

  home.stateVersion = "24.11";

  home.username = "${username}";
  home.homeDirectory = "${homeDirectory}";
}
