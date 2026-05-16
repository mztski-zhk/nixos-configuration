{ self, ... }: {
  flake.homeModules.homeSetBase = {
    imports = with self.homeModules; [
      cli
      develop
      tuiEditors
    ];
  };
}
