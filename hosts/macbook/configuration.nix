{ pkgs, inputs, ... }:

let
  username = "danny";
  hostname = "Dannys-MacBook-Pro";
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../../modules/nix-darwin
  ];

  myModules.nix-darwin = {
    firewall.enable = true;
    homebrew.enable = true;
  };

  system.stateVersion = 5;
  system.primaryUser = username;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.self.overlays.default ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      repodir = "/Users/${username}/Code/nix-config";
    };
    users.${username} = import ./home.nix;
  };

  users.knownUsers = [ username ];
  users.users.${username} = {
    uid = 501;
    name = username;
    home = "/Users/${username}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  nix-homebrew = {
    enable = true;
    user = username;
    autoMigrate = true;
  };

  homebrew.casks = [
    "brave-browser"
    "dbeaver-community"
    "discord"
    "docker-desktop"
    "ghostty"
    "nikitabobko/tap/aerospace"
    "obs"
    "protonvpn"
    "rectangle-pro"
    "scroll-reverser"
    "slack"
    "syncthing-app"
    "tailscale-app"
    "virtualbuddy"
    "visual-studio-code"
    "vlc"
    "zoom"
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;

  networking.localHostName = hostname;
}
