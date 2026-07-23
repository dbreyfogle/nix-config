{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myModules.home-manager.nvidia;
in
{
  options.myModules.home-manager.nvidia = {
    enable = lib.mkEnableOption "NVIDIA configuration";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      btop.package = pkgs.btop.override { cudaSupport = true; };
      obs-studio.package = pkgs.obs-studio.override { cudaSupport = true; };
    };
  };
}
