{ self, ... }: {
  flake.nixosModules.remote = {
    imports = with self.nixosModules; [
      sunshine
    ];
  };
}
