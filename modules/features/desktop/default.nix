{self, ...}: {
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      xdg
      greetd
      niri
    ];
  };
}
