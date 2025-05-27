{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python312Full;
      in
      {
        devShells.default = pkgs.mkShell {
          packages =
            [ python ]
            ++ (with pkgs; [
              ruff
              uv
            ]);
          env =
            {
              UV_PYTHON_DOWNLOADS = "never";
              UV_PYTHON = python.interpreter;
            }
            // nixpkgs.lib.optionalAttrs pkgs.stdenv.isLinux {
              LD_LIBRARY_PATH = nixpkgs.lib.makeLibraryPath pkgs.pythonManylinuxPackages.manylinux1;
            };
          shellHook = ''
            unset PYTHONPATH
          '';
        };
      }
    );
}
