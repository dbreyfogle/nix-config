{ inputs, ... }:

final: prev: {
  stable = import inputs.nixpkgs-stable {
    system = prev.system;
    config.allowUnfree = prev.config.allowUnfree;
  };

  terraform-versions = inputs.nixpkgs-terraform.packages.${prev.system};

  detect-term-background = prev.callPackage ../pkgs/detect-term-background.nix { };

  dbt-fusion = prev.callPackage ../pkgs/dbt-fusion.nix { };
}
