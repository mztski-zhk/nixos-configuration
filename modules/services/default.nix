{ self, ... }: {
  flake.nixosModules.services = {
    imports = with self.nixosModules; [
      podman

      nginx
    ];
  };
}
