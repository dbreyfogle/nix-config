{ inputs, ... }:

final: prev: {
  unstable = inputs.nixpkgs-unstable.legacyPackages.${final.system};
}
