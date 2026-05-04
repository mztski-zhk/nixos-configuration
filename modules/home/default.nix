{ self, ... }: {
  flake.nixosModules.home = {
    imports = with self.nixosModules; [
      users
      ./_home-manager.nix
    ];
  };
}
