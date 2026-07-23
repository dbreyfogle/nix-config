{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myModules.nixos.nvidia;
in
{
  options.myModules.nixos.nvidia = {
    enable = lib.mkEnableOption "NVIDIA configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-ld.libraries = [ config.hardware.nvidia.package ]; # CUDA

    services.xserver.videoDrivers = [ "nvidia" ]; # for nvidia-container-toolkit

    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      };
      nvidia = {
        open = true;
        modesetting.enable = true;
        powerManagement.enable = true;
      };
      nvidia-container-toolkit.enable = true;
    };
  };
}
