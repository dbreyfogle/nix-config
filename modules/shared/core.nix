{ ... }:

{
  nix.settings = {
    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [
      "https://nixpkgs-terraform.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw="
    ];
  };
}
