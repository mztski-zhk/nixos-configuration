{ self, inputs, ... }: {
  flake.modules.nixos = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelParams = [ "acpi_backlight=vendor" ];
  };
}