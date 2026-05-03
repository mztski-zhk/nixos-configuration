{ self, ... }: {
  flake.homeManagerModules.develop = {
    imports = with self.homeManagerModules; [
      direnv
    ];
  };
}
