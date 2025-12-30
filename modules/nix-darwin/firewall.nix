{ config, lib, ... }:

let
  cfg = config.myModules.nix-darwin.firewall;
in
{
  options.myModules.nix-darwin.firewall = {
    enable = lib.mkEnableOption "Firewall settings";
  };

  config = lib.mkIf cfg.enable {
    networking.applicationFirewall = {
      enable = true;
      allowSigned = true;
      allowSignedApp = true;
      blockAllIncoming = false;
      enableStealthMode = false;
    };
  };
}
