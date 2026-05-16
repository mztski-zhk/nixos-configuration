{ self, ... }: {
  flake.homeModules.develop = {
    imports = with self.homeModules; [
      direnv
    ];
  };
}
