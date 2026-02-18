{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myModules.home-manager.gnome;
in
{
  options.myModules.home-manager.gnome = {
    enable = lib.mkEnableOption "Customized GNOME desktop environment";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [
      alphabetical-app-grid
      blur-my-shell
      dash-to-dock
      disable-workspace-animation
      just-perfection
      space-bar
      tiling-shell
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/input-sources" = {
          xkb-options = [ "ctrl:nocaps" ];
        };

        "org/gnome/desktop/interface" = {
          clock-format = "12h";
          clock-show-seconds = true;
          clock-show-weekday = true;
          color-scheme = "prefer-dark";
          enable-hot-corners = false;
          show-battery-percentage = true;
        };

        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
          speed = 0.3;
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          speed = 0.0;
        };

        "org/gnome/desktop/privacy" = {
          old-files-age = lib.gvariant.mkUint32 30;
          remember-recent-files = false;
          remove-old-temp-files = true;
          remove-old-trash-files = true;
          report-technical-problems = false;
        };

        "org/gnome/desktop/screensaver" = {
          lock-delay = lib.gvariant.mkUint32 30;
        };

        "org/gnome/desktop/session" = {
          idle-delay = lib.gvariant.mkUint32 900;
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" ];
          maximize = [ "<Super>Up" ];
          minimize = [ "<Super>m" ];
          move-to-center = [ "<Super>c" ];
          move-to-workspace-1 = [ "<Shift><Super>1" ];
          move-to-workspace-2 = [ "<Shift><Super>2" ];
          move-to-workspace-3 = [ "<Shift><Super>3" ];
          move-to-workspace-4 = [ "<Shift><Super>4" ];
          move-to-workspace-5 = [ "<Shift><Super>5" ];
          move-to-workspace-6 = [ "<Shift><Super>6" ];
          move-to-workspace-7 = [ "<Shift><Super>7" ];
          move-to-workspace-8 = [ "<Shift><Super>8" ];
          move-to-workspace-9 = [ "<Shift><Super>9" ];
          move-to-workspace-10 = [ "<Shift><Super>0" ];
          switch-applications = [ "<Super>Tab" ];
          switch-applications-backward = [ "<Shift><Super>Tab" ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-6 = [ "<Super>6" ];
          switch-to-workspace-7 = [ "<Super>7" ];
          switch-to-workspace-8 = [ "<Super>8" ];
          switch-to-workspace-9 = [ "<Super>9" ];
          switch-to-workspace-10 = [ "<Super>0" ];
          switch-windows = [ "<Alt>Tab" ];
          switch-windows-backward = [ "<Shift><Alt>Tab" ];
          unmaximize = [ "<Super>Down" ];
        };

        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = 5;
        };

        "org/gnome/mutter" = {
          center-new-windows = true;
          dynamic-workspaces = false;
          edge-tiling = true;
          workspaces-only-on-primary = true;
        };

        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [ "<Super>Left" ];
          toggle-tiled-right = [ "<Super>Right" ];
        };

        "org/gnome/nautilus/list-view" = {
          use-tree-view = true;
        };

        "org/gnome/nautilus/preferences" = {
          click-policy = "double";
          date-time-format = "simple";
          default-folder-viewer = "list-view";
        };

        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
          night-light-schedule-automatic = false;
          night-light-schedule-from = 18.0;
          night-light-schedule-to = 6.0;
          night-light-temperature = lib.gvariant.mkUint32 4200;
        };

        "org/gnome/settings-daemon/plugins/power" = {
          power-button-action = "interactive";
          sleep-inactive-ac-timeout = 7200;
          sleep-inactive-ac-type = "suspend";
          sleep-inactive-battery-timeout = 1800;
        };

        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            alphabetical-app-grid.extensionUuid
            blur-my-shell.extensionUuid
            dash-to-dock.extensionUuid
            disable-workspace-animation.extensionUuid
            just-perfection.extensionUuid
            space-bar.extensionUuid
            tiling-shell.extensionUuid
          ];
        };

        "org/gnome/shell/app-switcher" = {
          current-workspace-only = false;
        };

        "org/gnome/shell/extensions/dash-to-dock" = {
          dance-urgent-applications = false;
          dash-max-icon-size = 60;
          disable-overview-on-startup = true;
          hot-keys = false;
          intellihide = false;
          isolate-locations = false;
          require-pressure-to-show = false;
          scroll-to-focused-application = false;
          show-dock-urgent-notify = false;
          show-icons-emblems = false;
          show-mounts = false;
          show-trash = false;
          workspace-agnostic-urgent-windows = false;
        };

        "org/gnome/shell/extensions/just-perfection" = {
          startup-status = 0;
          support-notifier-type = 0;
          workspace-popup = false;
        };

        "org/gnome/shell/extensions/space-bar/behavior" = {
          toggle-overview = false;
        };

        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [ ];
          switch-to-application-2 = [ ];
          switch-to-application-3 = [ ];
          switch-to-application-4 = [ ];
          switch-to-application-5 = [ ];
          switch-to-application-6 = [ ];
          switch-to-application-7 = [ ];
          switch-to-application-8 = [ ];
          switch-to-application-9 = [ ];
          switch-to-application-10 = [ ];
          toggle-message-tray = [ "<Super>v" ];
        };

        "org/gnome/shell/window-switcher" = {
          current-workspace-only = false;
        };

        "org/gtk/gtk4/settings/file-chooser" = {
          show-hidden = true;
          sort-directories-first = true;
        };
      };
    };
  };
}
