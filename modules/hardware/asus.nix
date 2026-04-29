{ self, inputs, ... }: {
  flake.modules.nixos.hardware.asus = {
    services.asusd = {
      enable = true;
    };
    services.power-profiles-daemon.enable = true;
    hardware.nvidia-container-toolkit.enable = true;
  };
}