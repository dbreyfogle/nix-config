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
  });

  minikube = prev.minikube.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      rm -f $out/bin/kubectl
    '';
  });
}
