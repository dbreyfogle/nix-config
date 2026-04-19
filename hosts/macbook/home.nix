{ config, repodir, ... }:

{
  imports = [ ../../modules/home-manager ];

  myModules.home-manager = {
    terminal.enable = true;
  };

  home.stateVersion = "26.05";

  programs.ghostty = {
    package = null;
    settings = {
      font-size = 15;
      window-padding-x = "4,0";
      window-padding-y = "12,4";
    };
  };

  xdg.configFile = {
    "aerospace".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/aerospace";
  };
}
