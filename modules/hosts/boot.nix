{...}: {
  flake.nixosModules.boot = {config, ...}: {
    boot.kernelParams = [
      # "acpi_backlight=native"
      # "amdgpu.backlight=0"
      "nvidia.NVreg_EnableBacklightHandler=1"
    ]; # fix backlight system service error

    # <-- bootloader -->
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
