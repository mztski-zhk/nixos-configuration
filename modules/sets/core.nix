{ self, ... }: {
  flake.nixosModules.setCore = {
    imports = with self.nixosModules; [
      nix
      hosts
      security
      home
    ];
  };
}
