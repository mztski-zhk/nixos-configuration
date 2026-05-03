{ self, ... }: {
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      greetd
      niri
      swaylock
      waybar
    ];
  };
}
