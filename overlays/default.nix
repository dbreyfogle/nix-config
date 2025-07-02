{ inputs, ... }:

final: prev: {
  stable = import inputs.nixpkgs-stable {
    system = prev.system;
    config.allowUnfree = prev.config.allowUnfree;
  };

  terraform-versions = inputs.nixpkgs-terraform.packages.${prev.system};

  dbt-fusion = prev.callPackage ../pkgs/dbt-fusion/package.nix { };
}
