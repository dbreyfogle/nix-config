{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";
  };

  outputs =
    { nixpkgs, nixpkgs-terraform, ... }:
    let
      inherit (nixpkgs) lib;
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ nixpkgs-terraform.overlays.default ];
          };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              terraform-versions."terraform-1.14"
            ];
          };
        }
      );
    };
}
