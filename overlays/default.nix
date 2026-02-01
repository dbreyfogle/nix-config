{ inputs, ... }:

final: prev: {
  stable = import inputs.nixpkgs-stable {
    inherit (prev) system;
    config.allowUnfree = prev.config.allowUnfree;
  };
  terraform-versions = inputs.nixpkgs-terraform.overlays.default final prev;
  astro-cli = prev.callPackage ../pkgs/astro-cli/package.nix { };
  dbt-fusion = prev.callPackage ../pkgs/dbt-fusion/package.nix { };

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
}
