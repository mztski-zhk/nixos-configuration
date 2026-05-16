{ self, ... }: {
  flake.nixosModules.setDesktop = {
    imports = with self.nixosModules; [
      audio
      features
    ];
  };
}
