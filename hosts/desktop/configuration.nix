{ pkgs, inputs, ... }:

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
    gnome-boxes
    gparted
    sshfs
    wl-clipboard
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  virtualisation.libvirtd.enable = true;

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

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Phoenix";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
  };
  hardware.nvidia-container-toolkit.enable = true;
}
