{ inputs, ... }:

final: prev: {
  stable = inputs.nixpkgs-stable.legacyPackages.${final.system};

  etcd = prev.callPackage ../pkgs/etcd.nix { };
}
