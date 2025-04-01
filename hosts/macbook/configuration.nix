{ pkgs, inputs, ... }:

let
  username = "danny";
  hostname = "Dannys-MacBook-Pro";
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../../modules/nix-darwin/system.nix
  ];

  system.stateVersion = 5;
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [ (import ../../overlays { inherit inputs; }) ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      repodir = "/Users/${username}/Code/nix-config";
    };
    users.${username} = import ./home.nix;
  };

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  nix-homebrew = {
    enable = true;
    user = "${username}";
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    autoMigrate = true;
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "alacritty"
      "brave-browser"
      "discord"
      "docker"
      "obsidian"
      "parsec"
      "protonvpn"
      "rectangle-pro"
      "scroll-reverser"
      "slack"
      "tailscale"
      "virtualbuddy"
      "visual-studio-code"
      "zoom"
    ];
  };

  environment.systemPackages = with pkgs; [
    coreutils
    gnumake
    gnused
  ];

  services.openssh.enable = true;

  networking.localHostName = "${hostname}";
}
