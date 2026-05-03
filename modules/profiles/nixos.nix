{ self, inputs, ... }: {
  flake.nixosModules.nixos = {
    # <-- Ultimate nixos config -->
    imports = with self.nixosModules; [
      nix
      audio
      features
      fix
      home
      hosts
      security
      services

      inputs.home-manager.nixosModules.home-manager
      {
        system.stateVersion = "26.05";
        home-manager.users.mztski-zhk.home.stateVersion = "25.11";
      }
    ];
  };
}
