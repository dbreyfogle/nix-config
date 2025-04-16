{ inputs, ... }:

final: prev: {
  stable = import inputs.nixpkgs-stable {
    system = prev.system;
    config.allowUnfree = prev.config.allowUnfree;
  };

  etcd = prev.callPackage ../pkgs/etcd.nix { };
}
