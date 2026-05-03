{ self, inputs, ... }: {

  systems = ["x86_64-linux"];
  
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixos
    ];
  };
}
