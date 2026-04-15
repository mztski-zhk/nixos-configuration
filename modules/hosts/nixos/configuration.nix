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
      self.nixosModules.nixosHardware
      self.nixosModules.niri
      self.nixosModules.gaming

      inputs.home-manager.nixosModules.home-manager
      inputs.impermanence.nixosModules.impermanence
    ];

    # <-- Core System Settings -->
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
    time.timeZone = "Asia/Hong_Kong";
    i18n.defaultLocale = "en_US.UTF-8";

    boot.kernelParams = [ "acpi_backlight=vendor" ];


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
      jq

      xwayland-satellite
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome

      tailscale
    ];

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji

        jetbrains-mono

        nerd-fonts.jetbrains-mono
        noto-fonts-cjk-sans
      ];
      fontconfig = {
        defaultFonts = {
          serif = ["Noto Serif"];
          sansSerif = ["Noto Sans"];
          monospace = ["JetBrainsMono Nerd Font"];
        };
      };
    };

    # <-- User Configuration -->
    users.mutableUsers = false;
    users.users.mztski-zhk = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "video"];
      hashedPassword = "$6$5VN3r4VBBPeB7PhY$FpevX.7qOf8M5OKPKNvQ2vRRxy6ny9LFVqdZFxjUwCy.UnU77vRcW8b5bVoqDK.R3YbgYtZbrJDaMnOY4AHZO/";
      
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPL+DcGvwyp7PYJ88GB5oCZ2sps0XICDMQLZgqWvxMex"
      ];
    };


    # <-- Audio Realtime Kit -->
    security.rtkit.enable = true;


    # <-- Firewall -->
    networking.firewall = {
      enable = true;
      # allowedTCPPorts = [  ];
      trustedInterfaces = [ "tailscale0" ];
    };

    security.apparmor = {
      enable = true;
      enableCache = true;
      killUnconfinedConfinables = true;
      packages = [
        pkgs.apparmor-parser
      ];
    };

    services.fail2ban = {
      enable = true;
      # Ban IP after 5 failures
      maxretry = 5;
      ignoreIP = [
        # Allow list for some subnets
        "127.0.0.1/8" "172.16.0.0/12" "192.168.0.0/16" "100.64.0.0/10"
        "8.8.8.8" "1.1.1.1" # allow a specific IP
        "wiki.nixos.org" # resolve the IP via DNS
      ];
      bantime = "24h"; # Ban IPs for one day on the first ban
      bantime-increment = {
        enable = true; # Enable increment of bantime after each violation
	formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
	# multipliers = "1 2 4 8 16 32 64";
	maxtime = "168h"; # Do not ban for more than 1 week
	overalljails = true; # Calculate the bantime based on all the violations
      };
      jails = {
        nginx-http-auth = ''
          enabled  = true
          port     = http,https
          logpath  = /var/log/nginx/*.log
          backend  = polling
          journalmatch =
        '';
        nginx-botsearch = ''
          enabled  = true
          port     = http,https
          logpath  = /var/log/nginx/*.log
          backend  = polling
          journalmatch =
        '';
        nginx-bad-request = ''
          enabled  = true
          port     = http,https
          logpath  = /var/log/nginx/*.log
          backend  = polling
          journalmatch =
        '';
      };
    };


    # <-- VPN & mesh -->
    services.tailscale.enable = true;
    

    # <-- SSH & GPG -->
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    programs.mosh.enable = true;
    services.openssh = {
      enable = true;
      ports = [ 14690 ];
      settings = {
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = true;
        PermitRootLogin = "no";
        AllowUsers = [ "mztski-zhk" ];
      };
    };


    # <-- Nginx -->
    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      appendHttpConfig = ''
        # Enable content policy
        add_header 'Referrer-Policy' 'origin-when-cross-origin';

	# Disable embedding as a frame
	add_header X-Frame-Options DENY;

	# Prevent injection of code in other mime types (XSS Attacks)
	add_header X-Content-Type-Options nosniff;
      '';

      virtualHosts."mztski-zhk.cc" =  {
	enableACME = false;
	forceSSL = false;
	locations."/" = {
	  proxyPass = "http://127.0.0.1:80";
	  proxyWebsockets = false;
	  extraConfig =
	    # required when the target is also TLS server with multiple hosts
	    "proxy_ssl_server_name on;" +
	    # required when the server wants to use HTTP Authentication
	    "proxy_pass_header Authorization;"
	    ;
	};
      };
    };


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


    # <-- Password -->
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;


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

        direnv-init = "cp /etc/nixos/templates/direnv/python/flake.nix . && cp /etc/nixos/templates/direnv/.envrc . && git init -b main . && git add . && direnv allow && git commit -m 'Direnv init'";
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
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;
      nvidiaSettings = true;

      # Hybrid Graphic
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:100:0:0";
        amdgpuBusId = "PCI:101:0:0";
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
      StandardError = "journal";
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
