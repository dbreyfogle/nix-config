{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.tiling-shell
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
        clock-show-seconds = true;
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
        speed = 0.3;
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
        maximize = [ "<Super>Up" ];
        move-to-workspace-left = [ "<Shift><Super>J" ];
        move-to-workspace-right = [ "<Shift><Super>K" ];
        switch-applications = [ ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
        switch-to-workspace-left = [ "<Super>J" ];
        switch-to-workspace-right = [ "<Super>K" ];
        switch-windows = [ "<Alt>Tab" ];
        unmaximize = [ "<Super>Down" ];
      };

      "org/gnome/mutter" = {
        center-new-windows = true;
        dynamic-workspaces = true;
        edge-tiling = true;
        workspaces-only-on-primary = false;
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
        sleep-inactive-ac-timeout = 7200;
        sleep-inactive-ac-type = "suspend";
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          alphabetical-app-grid.extensionUuid
          tiling-shell.extensionUuid
        ];
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
}
