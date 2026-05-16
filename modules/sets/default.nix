{ self, ... }: {
  flake.nixosModules.sets = {
    imports = with self.nixosModules; [
      setCore
      setDesktop
      setServices
    ];
  };
}
