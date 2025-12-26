{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              python3
              uv
            ];
            env = lib.optionalAttrs pkgs.stdenv.isLinux {
              LD_LIBRARY_PATH =
                lib.makeLibraryPath pkgs.pythonManylinuxPackages.manylinux1
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
    };
}
