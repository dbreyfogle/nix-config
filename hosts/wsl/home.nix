{ ... }:

{
  imports = [ ../../modules/home-manager ];

  myModules.home-manager = {
    terminal.enable = true;
  };

  home.stateVersion = "24.11";
}
