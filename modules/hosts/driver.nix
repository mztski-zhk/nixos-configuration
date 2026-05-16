{...}: {
  flake.nixosModules.driver = {
    config,
    lib,
    ...
  }: {
    # <-- Power control -->
    services.power-profiles-daemon.enable = true;

    # <-- Nvidia driver -->
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    boot.initrd.kernelModules = ["amdgpu"];
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

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
  };
}
