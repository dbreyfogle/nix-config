{ config, repodir, ... }:

{
  imports = [
    ../../modules/home-manager/core.nix
    ../../modules/home-manager/terminal.nix
  ];

  home.stateVersion = "24.11";

  programs.ghostty.settings = {
    font-size = 15;
    window-padding-x = "6,0";
    window-padding-y = "10,5";
  };

  xdg.configFile = {
    "aerospace".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/aerospace";
  };
}
