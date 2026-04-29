{ config, inputs, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.impermanence.nixosModules.impermanence
      config.flake.modules.nixos.nix
      config.flake.modules.nixos.networking
      config.flake.modules.nixos.boot
      config.flake.modules.nixos.audio.pipewire
      config.flake.modules.nixos.desktop.fonts
      config.flake.modules.nixos.desktop.shell
      config.flake.modules.nixos.desktop.display-manager
      config.flake.modules.nixos.hardware.nvidia
      config.flake.modules.nixos.hardware.asus
      config.flake.modules.nixos.development.containers
      config.flake.modules.nixos.development.tools
      config.flake.modules.nixos.services.nginx
      config.flake.modules.nixos.services.ssh
      config.flake.modules.nixos.services.vpn
      config.flake.modules.nixos.services.remote-control
      config.flake.modules.nixos.security.firewall
      config.flake.modules.nixos.security.users
      config.flake.modules.nixos.security.impermanence
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-backup";
          extraSpecialArgs = { inherit inputs; };
          users.mztski-zhk = {
            imports = [
              ../../../users/mztski-zhk/home.nix
            ];
          };
        };
        system.stateVersion = "25.11";
      }
    ];
  };
}