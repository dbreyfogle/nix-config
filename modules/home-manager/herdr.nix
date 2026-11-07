{
  config,
  lib,
  pkgs,
  repodir,
  ...
}:

let
  cfg = config.myModules.home-manager.herdr;
  defaultSettings = lib.importJSON ../../dotfiles/herdr/settings.json;
  mergedSettings = lib.recursiveUpdate defaultSettings cfg.settings;
in
{
  options.myModules.home-manager.herdr = {
    enable = lib.mkEnableOption "Herdr desktop app for terminals and coding agents";

    settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.json;
      default = { };
      description = "Settings to merge with dotfiles/herdr/settings.json";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.optional pkgs.stdenv.isLinux pkgs.unstable.herdr-desktop;

    xdg.configFile = {
      "herdr-app/keys.json".source =
        config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/herdr/keys.json";
      "herdr-app/settings.json".text = builtins.toJSON mergedSettings;
      "herdr-app/themes/kanagawa.json".source =
        config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/herdr/themes/kanagawa.json";
    };
  };
}
