{ pkgs, inputs, ... }:

let
  username = "danny";
  hostname = "framework";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ./disko.nix
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  myModules.nixos = {
    gnome.enable = true;
  };

  system.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.self.overlays.default ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      repodir = "/home/${username}/Code/nix-config";
    };
    users.${username} = import ./home.nix;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "Danny Breyfogle";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    gparted
  ];

  programs = {
    nix-ld.enable = true;
    zsh.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    docker.storageDriver = "overlay2";
    libvirtd.enable = true;
  };

  services = {
    fwupd.enable = true;

    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      HandleLidSwitchDocked = "ignore";
    };

    openssh.enable = true;
    openssh.openFirewall = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;

    syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = username;
      group = "users";
      dataDir = "/home/${username}";
    };

    tailscale = {
      enable = true;
      extraSetFlags = [ "--accept-routes" ];
      openFirewall = true;
      useRoutingFeatures = "client";
    };
  };

  networking = {
    firewall.enable = true;
    hostName = hostname;
    networkmanager.enable = true;
  };

  hardware.graphics.enable = true;

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  security.rtkit.enable = true;

  time.timeZone = "America/Phoenix";

  i18n.defaultLocale = "en_US.UTF-8";
}
