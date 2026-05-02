{ self, inputs, ... }: {
  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.desktopHardware

      self.nixosModules.git
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking = {
      hostName = "nixos";
      # Use networkmanager for network configuration.
      networkmanager.enable = true;
    };

    # Locale.
    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };

    # X11 windowing system.
    services.xserver = {
      enable = true;

      # Keyboard layout.
      xkb = {
        layout = "us";
        variant = "mac-iso";
      };
    };
    # GNOME desktop environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # System audio with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Printing support with CUPS.
    services.printing.enable = true;

    # User accounts.
    users.users = {
      zalanlevai = {
        isNormalUser = true;
        description = "Zalán Bálint Lévai";
        extraGroups = ["networkmanager" "wheel"];
        packages = with pkgs; [];
      };
    };

    # Packages.

    # Enable modern nix features.
    nix.settings.experimental-features = ["nix-command" "flakes"];
    # Allow unfree packages.
    nixpkgs.config.allowUnfree = true;

    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [];

    # System state version.
    # NOTE: This value determines the NixOS release from which the default settings for stateful data were taken.
    #       This includes file locations and database versions.
    #       It is recommended to leave this value at the release version of the first install of this system.
    #       See `man configuration.nix` or https://nixos.org/nixos/options.html.
    system.stateVersion = "25.11";
  };
}
