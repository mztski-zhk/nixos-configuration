{ self, ... }: {
  # <-- Current configuration, include all sets of modules -->
  # <-- for my daily use                                   -->
  flake.homeModules.homeProfileNixos = {
    imports = with self.homeModules; [
      homeSetBase
      homeSetDesktop
      homeSetNixosPackages
      homeSetQol
    ];
  };
}
