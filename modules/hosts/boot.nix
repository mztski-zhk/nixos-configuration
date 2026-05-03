{ ... }: {
  flake.nixosModules.boot = {
    boot.kernelParams = [ "acpi_backlight=vendor" ]; # fix backlight system service error
    
    # <-- bootloader -->
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
