{
  config,
  pkgs,
  inputs,
  ...
}:

let
  username = "danny";
  hostname = "nixos";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  myModules.nixos = {
    gnome.enable = true;
    inhibitSleepDuringSsh.enable = true;
  };

  system.stateVersion = "24.11";

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
    nix-ld = {
      enable = true;
      libraries = [
        config.hardware.nvidia.package # CUDA
      ];
    };
    zsh.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    docker.storageDriver = "btrfs";
    libvirtd.enable = true;
  };

  services = {
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

    xserver.videoDrivers = [ "nvidia" ]; # for nvidia-container-toolkit
  };

  networking = {
    firewall.enable = true;
    hostName = hostname;
    networkmanager.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
    nvidia-container-toolkit.enable = true;
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      windows = {
        "windows" = {
          title = "Windows";
          efiDeviceHandle = "FS0";
          sortKey = "y_windows";
        };
      };
      edk2-uefi-shell.enable = true;
      edk2-uefi-shell.sortKey = "z_edk2";
    };
  };

  security.rtkit.enable = true;

  time.timeZone = "America/Phoenix";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";
}
