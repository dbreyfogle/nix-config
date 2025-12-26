{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";
  };

  outputs =
    { nixpkgs, nixpkgs-terraform, ... }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          terraform = nixpkgs-terraform.packages.${system}."terraform-1.14";
        in
        {
          default = pkgs.mkShell {
            packages = [
              terraform
            ];
          };
        }
      );
    };
}
