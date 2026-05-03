{ self, ... }: {
  flake.nixosModules.features = {
    imports = with self.nixosModules; [
      desktop
      fonts
      gaming
      remote
    ];
  };
}
