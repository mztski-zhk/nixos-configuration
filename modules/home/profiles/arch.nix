{ self, ... }: {
  # TODO: improve home-manager for my arch linux
  flake.homeModules.homeProfileArch = {
    imports = with self.homeModules; [
      homeSetBase
      homeSetDesktop
      homeSetNixosPackages
    ];
  };
}
