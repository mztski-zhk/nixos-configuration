{self, ...}: {
  flake.homeModules.desktop = {
    imports = with self.homeModules; [
      catppuccin
      gtk
      qt
      xdg

      cliphist

      swaylock

      brave
    ];
  };
}
