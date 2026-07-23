{ inputs, ... }:

final: prev: {
  stable = import inputs.nixpkgs-stable {
    system = prev.stdenv.hostPlatform.system;
    config.allowUnfree = prev.config.allowUnfree;
  };

  astro-cli = prev.callPackage ../pkgs/astro-cli/package.nix { };

  brave = prev.brave.overrideAttrs (oldAttrs: {
    preFixup =
      builtins.replaceStrings
        # Enable swipe gestures for page navigation
        [ "--enable-features=" ] [ "--enable-features=TouchpadOverscrollHistoryNavigation," ]
        (oldAttrs.preFixup or "");

    postInstall =
      (oldAttrs.postInstall or "")
      # Remove duplicate desktop item
      + prev.lib.optionalString prev.stdenv.hostPlatform.isLinux ''
        rm -f $out/share/applications/com.brave.Browser.desktop
      '';
  });

  # https://github.com/NixOS/nixpkgs/issues/509480
  gotools = prev.symlinkJoin {
    name = "gotools";
    paths = [ prev.gotools ];
    postBuild = ''
      rm -f "$out/bin/modernize"
    '';
  };
}
