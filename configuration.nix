{ config, pkgs, inputs, system,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/nixos/nvidia.nix
      inputs.home-manager.nixosModules.default
      inputs.nix-minecraft.nixosModules.minecraft-servers
      inputs.nvf.nixosModules.default
    ];
  nixpkgs.overlays =
    [
    inputs.nix-minecraft.overlay
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "joydev" "kvm-intel" "i2c-dev" "i2c-piix4" "hid-nintendo" "v4l2loopback" "hid_sony" "sixaxis" ];
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 card_label="OBS Cam" exclusive_caps=1
  '';

  networking.hostName = "quote"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Bluea tootha stuff
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.xpadneo.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.settings = { General = {
    Enable = "Source,Sink,Media,Socket";
  };};

 # OPENGL
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-tools
    ];
  };

  services.mullvad-vpn.enable = true;
  programs.nix-ld.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="4001", MODE="0666"
    SUBSYSTEM=="input", ATTRS{name}=="*Sony PLAYSTATION*Controller*", MODE="0666"
  '';

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "el_GR.UTF-8";
    LC_IDENTIFICATION = "el_GR.UTF-8";
    LC_MEASUREMENT = "el_GR.UTF-8";
    LC_MONETARY = "el_GR.UTF-8";
    LC_NAME = "el_GR.UTF-8";
    LC_NUMERIC = "el_GR.UTF-8";
    LC_PAPER = "el_GR.UTF-8";
    LC_TELEPHONE = "el_GR.UTF-8";
    LC_TIME = "el_GR.UTF-8";
  };

  # Optimise storage
  nix.optimise.automatic = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Disable KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = false;

  # Enable i3 window manager.
  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us_thorn";

    extraLayouts.us_thorn = {
      description = "us layout with þorn";
      languages = [ "eng" ];
      symbolsFile = pkgs.writeText "us_thorn" ''
        partial alphanumeric_keys
        xkb_symbols "basic" {
            include "us(basic)"
            name[Group1]= "English (US) with þ on CapsLock";
            key <CAPS> { [ thorn, THORN ] };
        };
      '';
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  virtualisation.docker.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable XDG portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.audio = {};
  users.users.quote = {
    isNormalUser = true;
    description = "quote";
    shell = pkgs.fish;
    extraGroups = [ "audio" "input" "libvirtd" "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Limits
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "quote" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  # stylix
  stylix.enable=true;
  stylix.polarity="dark";
  stylix.base16Scheme={
    base00= "2E3440";
    base01= "3B4252";
    base02= "434C5E";
    base03= "4C566A";
    base04= "D8DEE9";
    base05= "E5E9F0";
    base06= "ECEFF4";
    base07= "8FBCBB";
    base08= "BF616A";
    base09= "D08770";
    base0A= "EBCB8B";
    base0B= "A3BE8C";
    base0C= "88C0D0";
    base0D= "81A1C1";
    base0E= "B48EAD";
    base0F= "5E81AC";
  };
  stylix.image=./3xsraffkwi1a1.png;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font";
    };
    serif = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
  stylix.autoEnable = true;

  # Enable steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Use flatpak
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    bluez-tools
    bluez
    udiskie
    udisks2

    cloudflared
    flatpak
    wget
    kitty
    mangohud
    i3
    i3status
    i3lock
    starship

    xorg.xorgserver
    xorg.xrandr
    xorg.xinit
    xorg.xset
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXext
    xorg.libXi
    xorg.libXrandr
    xorg.xrdb
    xorg.libXi 
    cudatoolkit
    xorg.libXtst
    pkgs.xorg.libX11
    pkgs.xorg.libXtst
    pkgs.xorg.libXrandr
    xorg.libXtst

    ckb-next

    rofi
    v4l-utils
    fastfetch
    fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
    rustup
    git
    pkgs.feh
    pkgs.picom
    pkgs.dunst

    mesa

    docker

    pkgs.python3
    pkgs.pipx
    pkgs.python312Packages.pip
    pkgs.cloudflare-warp
    pkgs.helvum
    pkgs.pavucontrol
    pkgs.gcc
    pkgs.gnumake
    pkgs.i3blocks
    pkgs.binutils
    pkgs.home-manager
    neovim
    pkgs.nixd
    pkgs.bibata-cursors
    pkgs.pkg-config
  ];

  services.cloudflare-warp.enable = true;
  programs.fish.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Automounting
  services.udisks2.enable = true;

  # picom
  services.picom = {
    enable = true;
  };

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    kochi-substitute
    noto-fonts-emoji
    liberation_ttf
    mplus-outline-fonts.githubRelease
    nerd-fonts.blex-mono
  ];

  # Gaming settings
  services.xserver.videoDrivers = ["nvidia"];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  networking.firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  # FLAKES
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  system.stateVersion = "24.11"; # Did you read the comment?

}
