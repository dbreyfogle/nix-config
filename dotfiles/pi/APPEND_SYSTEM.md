Nix is installed and available on this machine with the nix-command and flakes experimental features enabled. Prefer Nix over other package managers when installing or running tools.

If a command does not exist:
- Search for an appropriate package that provides it using nix-locate --minimal --at-root --whole-name /bin/{command}
- Use nix shell nixpkgs#{package} -c {command} {args} to run the command in a temporary environment

The full system configuration lives in a flake at ~/Projects/nix-config. Make edits in that repository for system-wide changes.
