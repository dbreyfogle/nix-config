{ ... }:

{
  imports = [
    ../../modules/home-manager/core.nix
    ../../modules/home-manager/terminal.nix
  ];

  home.stateVersion = "24.11";
}
