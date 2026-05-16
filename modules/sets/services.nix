{ self, ... }: {
  flake.nixosModules.setServices = {
    imports = with self.nixosModules; [
      services
    ];
  };
}
