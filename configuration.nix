# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true; # required for the Nvidia driver

  # ---------- Boot / kernel ----------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10; # cap old generations so /boot (vfat) doesn't fill up

  boot.kernelPackages = pkgs.linuxPackages_latest; # newer kernel = better asus-wmi/ACPI + Nvidia support
  boot.kernelParams = [
    "acpi_backlight=native" # lets nvidia_wmi_ec_backlight control the panel (Ultimate/dGPU MUX mode)
  ];

  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  
  boot.tmp.cleanOnBoot = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tbilisi";
  i18n.defaultLocale = "en_US.UTF-8";

  # ---------- Desktop session ----------
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
  };
  services.displayManager.ly.enable = true;

  # ---------- Graphics: Nvidia ----------
  # Ultimate/dGPU MUX mode: panel is wired directly to the Nvidia GPU, iGPU is
  # bypassed entirely. No PRIME/offload block — that's only for hybrid mode.
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Steam/Proton/Wine
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true; # Turing/Ampere (TUF Dash F15 GPUs) — Nvidia's current recommendation; set false if you hit issues
    nvidiaSettings = true;
    powerManagement.enable = true; # fixes common sleep/resume corruption; flip off if suspend misbehaves
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # ---------- ASUS hardware ----------
  services.asusd.enable = true;

# Create required directories for asusd systemd sandboxing
  systemd.tmpfiles.rules = [
    "d /etc/asusd 0755 root root -"
    "d /var/lib/asusd 0755 root root -"
  ];

  # ---------- Audio ----------
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ---------- Bluetooth ----------
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # ---------- Power / thermal / storage ----------
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true; # Intel CPU thermal management
  services.fstrim.enable = true;
  zramSwap.enable = true;

  # ---------- Session plumbing ----------
  security.polkit.enable = true; # off by default; needed for GUI privilege prompts
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk
                                xdg-desktop-portal-hyprland
                              ];
  };
  programs.dconf.enable = true; # GTK app settings (theming, file pickers)

  services.fwupd.enable = true; # firmware updates

  
  # ---------- User ----------
  users.users.netrover = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # sudo
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  # ---------- System packages ----------
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    alacritty
    foot
    kitty
    hyprpaper
    asusctl
    pciutils # lspci
    usbutils # lsusb
    btop
    ripgrep
    fd
    nvtopPackages.nvidia
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
    symbola
  ];

  # ---------- Nix housekeeping ----------
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly. See `man configuration.nix` for more.
  system.stateVersion = "26.05"; # Did you read the comment?
}
