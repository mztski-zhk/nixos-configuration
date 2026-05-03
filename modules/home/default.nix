{ self, ... }: {
  flake.nixosModules.home = {
    imports = with self.nixosModules; [
      users
      home-manager
    ];
  };
}
