{ pkgs, inputs, ... }:

let
  username = "danny";
  hostname = "Dannys-MacBook-Pro";
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../../modules/shared/core.nix
    ../../modules/nix-darwin/system.nix
  ];

  system.stateVersion = 5;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.self.overlays.default ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      repodir = "/Users/${username}/Code/nix-config";
    };
    users.${username} = import ./home.nix;
  };

  users.knownUsers = [ username ];

  users.users.${username} = {
    uid = 501;
    name = "${username}";
    home = "/Users/${username}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  nix-homebrew = {
    enable = true;
    user = "${username}";
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
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

  environment.variables = {
    HOMEBREW_NO_ANALYTICS = "1";
  };

  environment.systemPackages = with pkgs; [
    coreutils
    gnused
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;

  networking.localHostName = "${hostname}";
}
