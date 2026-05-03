{ self, ... }: {
  flake.nixosModules.services = {
    imports = with self.nixosModules; [
      nginx
    ];
  };
}
