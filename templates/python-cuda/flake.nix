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
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        python = pkgs.python312Full;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            python
          ]
          ++ (with pkgs; [
            ruff
            uv
          ]);
          env = {
            UV_PYTHON_DOWNLOADS = "never";
            UV_PYTHON = python.interpreter;
          }
          // nixpkgs.lib.optionalAttrs pkgs.stdenv.isLinux {
            LD_LIBRARY_PATH =
              (nixpkgs.lib.makeLibraryPath pkgs.pythonManylinuxPackages.manylinux1)
              + ":/usr/lib/wsl/lib:${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib";
            CUDA_PATH = pkgs.cudatoolkit;
            EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
            EXTRA_CCFLAGS = "-I/usr/include";
          };
          shellHook = ''
            unset PYTHONPATH
          '';
        };
      }
    );
}
