{self, ...}: {
  flake.nixosModules.nix = {
    # <-- Ultimate nixos config -->
    imports = with self.nixosModules; [
      nixSettings
      nixOverlays
      nh
    ];
  };
}
