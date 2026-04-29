{
  description = "Modular NixOS Flake with Impermanence and Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hermes-agent.url = "github:NousResearch/hermes-agent";
    catppuccin.url = "github:catppuccin/nix";
    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = inputs@{ self, ... }:
    let
      # Import modular configurations
      nixModule = import ./modules/nix.nix { inherit self inputs; };
      networkingModule = import ./modules/networking.nix { inherit self inputs; };
      bootModule = import ./modules/boot.nix { inherit self inputs; };
      audioPipewireModule = import ./modules/audio/pipewire.nix { inherit self inputs; };
      desktopFontsModule = import ./modules/desktop/fonts.nix { inherit self inputs; };
      desktopShellModule = import ./modules/desktop/shell.nix { inherit self inputs; };
      desktopDisplayManagerModule = import ./modules/desktop/display-manager.nix { inherit self inputs; };
      hardwareNvidiaModule = import ./modules/hardware/nvidia.nix { inherit self inputs; };
      hardwareAsusModule = import ./modules/hardware/asus.nix { inherit self inputs; };
      developmentContainersModule = import ./modules/development/containers.nix { inherit self inputs; };
      developmentToolsModule = import ./modules/development/tools.nix { inherit self inputs; };
      servicesNginxModule = import ./modules/services/nginx.nix { inherit self inputs; };
      servicesSshModule = import ./modules/services/ssh.nix { inherit self inputs; };
      servicesVpnModule = import ./modules/services/vpn.nix { inherit self inputs; };
      servicesRemoteControlModule = import ./modules/services/remote-control.nix { inherit self inputs; };
      securityFirewallModule = import ./modules/security/firewall.nix { inherit self inputs; };
      securityUsersModule = import ./modules/security/users.nix { inherit self inputs; };
      securityImpermanenceModule = import ./modules/security/impermanence.nix { inherit self inputs; };
      hardwareConfigModule = import ./modules/hosts/nixos/hardware-configuration.nix { inherit self inputs; };
      binaryCacheModule = import ./modules/binary-cache/default.nix { inherit self inputs; };
      featuresAiModule = import ./modules/features/ai/default.nix { inherit self inputs; };
    in
    inputs.flake-parts.lib.mkFlake
      { inherit inputs; }
      ({
        systems = [ "x86_64-linux" ];
        imports = [
          (inputs.import-tree ./modules)
        ];
        flake = {
          # Define nixosConfigurations at the flake level using modular modules
          nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
            modules = [
              inputs.home-manager.nixosModules.home-manager
              inputs.impermanence.nixosModules.impermanence
              hardwareConfigModule.flake.nixosModules.nixosHardware
              nixModule.flake.nixosModules.nix
              binaryCacheModule.flake.nixosModules.binaryCache
              networkingModule.flake.nixosModules.networking
              bootModule.flake.nixosModules.boot
              audioPipewireModule.flake.nixosModules.audio.pipewire
              desktopFontsModule.flake.nixosModules.desktop.fonts
              desktopShellModule.flake.nixosModules.desktop.shell
              desktopDisplayManagerModule.flake.nixosModules.desktop.display-manager
              hardwareNvidiaModule.flake.nixosModules.hardware.nvidia
              hardwareAsusModule.flake.nixosModules.hardware.asus
              developmentContainersModule.flake.nixosModules.development.containers
              developmentToolsModule.flake.nixosModules.development.tools
              servicesNginxModule.flake.nixosModules.services.nginx
              servicesSshModule.flake.nixosModules.services.ssh
              servicesVpnModule.flake.nixosModules.services.vpn
              servicesRemoteControlModule.flake.nixosModules.services.remote-control
              securityFirewallModule.flake.nixosModules.security.firewall
              securityUsersModule.flake.nixosModules.security.users
              securityImpermanenceModule.flake.nixosModules.security.impermanence
              featuresAiModule.flake.nixosModules.features.ai.claude-code
              {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    backupFileExtension = "hm-backup";
                    extraSpecialArgs = { inherit inputs; };
                    users.mztski-zhk = {
                      imports = [
                        inputs.catppuccin.homeModules.catppuccin
                        ./users/mztski-zhk/home.nix
                      ];
                    };
                  };
                system.stateVersion = "25.11";
              }
            ];
          };
        };
      });
}