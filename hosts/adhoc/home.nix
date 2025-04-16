{ ... }:

let
  username = "root";
  homeDirectory = "/root";
  repodir = "/root/nix-config";
in
{
  _module.args.repodir = repodir;

  imports = [
    ../../modules/home-manager/terminal.nix
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  home.username = "${username}";
  home.homeDirectory = "${homeDirectory}";

  nix.registry = {
    nix-config = {
      to = {
        type = "path";
        path = repodir;
      };
    };
  };
}
