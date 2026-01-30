{ inputs, ... }:

final: prev: {
  stable = import inputs.nixpkgs-stable {
    inherit (prev) system;
    config.allowUnfree = prev.config.allowUnfree;
  };
  terraform-versions = inputs.nixpkgs-terraform.overlays.default final prev;
  astro-cli = prev.callPackage ../pkgs/astro-cli/package.nix { };
  dbt-fusion = prev.callPackage ../pkgs/dbt-fusion/package.nix { };

  # fix: remove duplicate brave desktop item
  brave = prev.brave.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + prev.lib.optionalString prev.stdenv.hostPlatform.isLinux ''
        rm -f $out/share/applications/com.brave.Browser.desktop
      '';
  });
}
