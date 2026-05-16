{ self, ... }: {
  flake.nixosModules.nixos = {
    # <-- Ultimate nixos config -->
    imports = with self.nixosModules; [
      sets
      fix

      {
        system.stateVersion = "26.05";
        home-manager.users.mztski-zhk.home.stateVersion = "26.05";
      }
    ];
  };
}
