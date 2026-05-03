{ self, ... }: {
  flake.nixosModules.nixos = {
    # <-- Ultimate nixos config -->
    imports = with self.nixosModules; [
      nixSettings

      audio
      features
      home
      hosts
      security
      services
    ];
  };
}
