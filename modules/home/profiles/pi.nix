{ self, ... }: {
  # TODO: test this module in raspberry pi
  # <-- Fewest imports and packages for low resource environments -->
  flake.homeModules.homeProfilePi = {
    imports = with self.homeModules; [
      homeSetBase
    ];
  };
}
