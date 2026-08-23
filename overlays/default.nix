{ inputs, ... }:

final: prev: {
  unstable = import inputs.nixpkgs-unstable {
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
  });
}
