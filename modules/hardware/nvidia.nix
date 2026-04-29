{ self, inputs, ... }: {
  flake.modules.nixos.hardware.nvidia = { lib, ... }: {
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;
      nvidiaSettings = true;
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