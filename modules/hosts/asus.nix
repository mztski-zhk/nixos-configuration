{ ... }: {
  flake.nixosModules.asus = {
    services.asusd = {
      enable = true;
    };
    services.supergfxd = {
      enable = true;
    };
  };
}
