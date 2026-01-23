{ inputs, ... }:

final: prev: {
  stable = import inputs.nixpkgs-stable { inherit (prev) system config; };
  terraform-versions = inputs.nixpkgs-terraform.overlays.default final prev;
  astro-cli = prev.callPackage ../pkgs/astro-cli/package.nix { };
  dbt-fusion = prev.callPackage ../pkgs/dbt-fusion/package.nix { };
}
