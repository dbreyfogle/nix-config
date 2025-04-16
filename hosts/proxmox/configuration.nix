{ pkgs, inputs, ... }:

let
  username = "root";
  hostname = "nixos-dev";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.11";
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [ inputs.self.overlays.default ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      repodir = "/root/Code/nix-config";
    };
    users.${username} = import ./home.nix;
  };

  users.users.${username} = {
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    gnumake
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.qemuGuest.enable = true;

  virtualisation.docker.enable = true;

  boot.loader.grub.enable = true;

  time.timeZone = "America/Phoenix";

  networking.hostName = "${hostname}";
  networking.networkmanager.enable = true;

  networking.firewall.enable = false;

  services.kubernetes = {
    roles = [
      "master"
      "node"
    ];
    masterAddress = "127.0.0.1";
    easyCerts = true;
  };
}
