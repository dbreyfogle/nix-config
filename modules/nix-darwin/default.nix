{ pkgs, ... }:

{
  imports = [
    ../shared
    ./firewall.nix
    ./homebrew.nix
  ];

  environment.systemPackages = with pkgs; [
    coreutils
    gnused
  ];

  system.startup.chime = false;

  system.defaults = {
    ".GlobalPreferences"."com.apple.mouse.scaling" = 1.0;
    ".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/Pop.aiff";

    CustomUserPreferences = {
      "com.apple.dock".no-bouncing = true;
      NSGlobalDomain."com.apple.mouse.linear" = true;
    };

    NSGlobalDomain = {
      AppleEnableMouseSwipeNavigateWithScrolls = true;
      AppleEnableSwipeNavigateWithScrolls = true;
      ApplePressAndHoldEnabled = false;
      AppleScrollerPagingBehavior = true;
      AppleShowScrollBars = "Automatic";
      AppleSpacesSwitchOnActivate = true;
      AppleWindowTabbingMode = "always";
      InitialKeyRepeat = 30;
      KeyRepeat = 2;
      NSWindowShouldDragOnGesture = true;
      "com.apple.keyboard.fnState" = false;
      "com.apple.sound.beep.feedback" = 0;
      "com.apple.sound.beep.volume" = 0.6065307;
      "com.apple.trackpad.scaling" = 0.6875;
    };

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

    WindowManager = {
      AppWindowGroupingBehavior = true;
      AutoHide = false;
      EnableStandardClickToShowDesktop = false;
      EnableTiledWindowMargins = false;
      EnableTilingByEdgeDrag = true;
      EnableTilingOptionAccelerator = false;
      EnableTopTilingByEdgeDrag = true;
      GloballyEnabled = false;
      HideDesktop = false;
      StageManagerHideWidgets = false;
      StandardHideDesktopIcons = false;
      StandardHideWidgets = false;
    };

    controlcenter = {
      BatteryShowPercentage = true;
      Sound = false;
    };

    dock = {
      autohide = true;
      expose-group-apps = true;
      launchanim = false;
      magnification = false;
      mineffect = "scale";
      minimize-to-application = true;
      mru-spaces = false;
      orientation = "bottom";
      show-process-indicators = true;
      show-recents = false;
      tilesize = 52;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true;
      NewWindowTarget = "Other";
      NewWindowTargetPath = "file:///Applications/";
      ShowExternalHardDrivesOnDesktop = false;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowPathbar = true;
      ShowRemovableMediaOnDesktop = false;
      ShowStatusBar = false;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
    };

    hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";

    menuExtraClock = {
      ShowDate = 0;
      ShowSeconds = true;
    };

    spaces.spans-displays = false;

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };
  };
}
