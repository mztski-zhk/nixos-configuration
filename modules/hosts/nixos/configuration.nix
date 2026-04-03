{
  self,
  inputs,
  ...
}: {

  systems = ["x86_64-linux"];

  flake.nixosModules.nixosConfiguration = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      # Hardware scan
      self.nixosModules.nixosHardware
      self.nixosModules.niri
      self.nixosModules.gaming

      inputs.home-manager.nixosModules.home-manager
      inputs.impermanence.nixosModules.impermanence

      # Core Modules
      #      ../../core/boot.nix
      #      ../../core/security.nix
      #      ../../core/persistence.nix

      # Desktop Modules
      # ../../desktop/niri.nix
      # ../../modules/desktop/fonts.nix

      # App Modules
      # ../../modules/apps/steam.nix
      # ../../modules/apps/vivaldi.nix
    ];

    # <-- Core System Settings -->
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
    time.timeZone = "Asia/Hong_Kong";
    i18n.defaultLocale = "en_US.UTF-8";

    nix.settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };


  programs.git = {
    enable = true;
    userName  = "mztski-zhk";
    userEmail = "mztski.zhk@gmail.com";
    
    # Optional but highly recommended:
    config = {
      init.defaultBranch = "main"; # Changes the default branch from 'master' to 'main'
      pull.rebase = true;          # Prevents messy merge commits when pulling
    };
  };


    # <-- Audio -->
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # <-- System Packages -->
    environment.systemPackages = with pkgs; [
      vim
      pciutils
      btrfs-progs
      sops
      git
      wget
      curl

      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        nerd-fonts.ubuntu
        nerd-fonts.ubuntu-sans
        nerd-fonts.jetbrains-mono
        noto-fonts-cjk-sans
      ];
      fontconfig = {
        defaultFonts = {
          serif = ["nerd-fonts.ubuntu"];
          sansSerif = ["nerd-fonts.ubuntu-sans"];
          monospace = ["nerd-fonts.jetbrains-mono"];
        };
      };
    };

    # <-- User Configuration -->
    users.mutableUsers = false;
    users.users.mztski-zhk = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "video"];
      # Your requested password hash
      hashedPassword = "$6$5VN3r4VBBPeB7PhY$FpevX.7qOf8M5OKPKNvQ2vRRxy6ny9LFVqdZFxjUwCy.UnU77vRcW8b5bVoqDK.R3YbgYtZbrJDaMnOY4AHZO/";
    };

    # <-- Audio Realtime Kit -->
    security.rtkit.enable = true;

    # <-- Firewall -->
    networking.firewall.enable = false;

    # <-- SSH & GPG -->
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    services.openssh.enable = true;

    # <-- Home Manager Integration -->
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
      extraSpecialArgs = {inherit inputs;};
      # Point to your modularized user home.nix
      users.mztski-zhk = {
        imports = [
          ../../../users/mztski-zhk/home.nix
          ];
      };
    };

    # <-- Shell -->
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        la = "ls -alFhXB --color=auto";
        ll = "ls -ltFhXB --color=auto";
        l = "ls -lFh --color=auto";
        lt = "ls -altFh";
        lx = "ls -lXB";

        update = "nix flake update && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
        nixos-clean = "sudo nix-collect-garbage --delete-older-than 7d";
        nixos-clean-all = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      };

      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      setOptions = [
        "HIST_IGNORE_ALL_DUPS"
      ];
    };
    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [zsh];

    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
      };
    };

    # <-- Gaming -->
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    # <-- NVIDIA Driver -->
    services.xserver.videoDrivers = ["amdgpu" "nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true; # Necessary for suspend/resume
      powerManagement.finegrained = true; # Turns off GPU when not in use
      open = true; # Use the NVIDIA Open Kernel Module (Recommended for 40-series)
      nvidiaSettings = true;

      # Hybrid Graphic
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:101:00:0";
        nvidiaBusId = "PCI:100:00:0";
      };
    };

    specialisation = {
      gaming-time.configuration = {
        hardware.nvidia = {
          powerManagement.finegrained = lib.mkForce false;
          prime = {
            sync.enable = lib.mkForce true;
            offload = {
              enable = lib.mkForce false;
              enableOffloadCmd = lib.mkForce false;
            };
          };
        };
      };
    };

    # Asus Specific Tools
    services.asusd = {
      enable = true;
    };

    # Power management
    services.power-profiles-daemon.enable = true;

    # <-- Bootloader -->
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;


    # Enable greetd
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd niri-session";
        user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1"; 
    };


    # <-- Impermanence -->
    programs.fuse.userAllowOther = true;

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/networkmanager/system-connections"
      ];
      files = [
        "/etc/machine-id"
        # /etc/shadow is safely omitted
      ];

      users.mztski-zhk = {
        directories = [
          "Applications"
          "Codes"
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".local/share/direnv"
          ".ssh"
          ".config/niri"
        ];
      };
    };

    # <-- Force machine-id to persist correctly -->
    system.activationScripts.iron-machine-id = ''
      mkdir -p /persist/etc
      touch /persist/etc/machine-id
      ln -snf /persist/etc/machine-id /etc/machine-id
    '';

    system.stateVersion = "25.11";
  };
}
