{self, ...}: {
  flake.homeModules.desktop = {
    imports = with self.homeModules; [
      mpris

      catppuccin
      gtk
      qt
      xdg

      cliphist

      waybar
      swaync
      swaylock

      brave
    ];
  };
}
