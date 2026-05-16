{ self, ... }: {
  # <-- home manager module -->
  flake.nixosModules.home = {
    # this is the nixos entrypoint for home-manager
    imports = [
      self.nixosModules.users
      self.nixosModules.home-manager
    ];
  };
}
