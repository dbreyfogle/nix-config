{ config, lib, ... }:

let
  cfg = config.myModules.nix-darwin.homebrew;
in
{
  options.myModules.nix-darwin.homebrew = {
    enable = lib.mkEnableOption "Homebrew package manager";
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
      };
    };

    environment.variables = {
      HOMEBREW_NO_ANALYTICS = "1";
    };
  };
}
