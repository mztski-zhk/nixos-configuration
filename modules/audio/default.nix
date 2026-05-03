{ self, ... }: {
  flake.nixosModules.audio = {
    imports = with self.nixosModules; [
      pipewire
    ];
  };
}
