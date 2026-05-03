{ self, ... }: {
  flake.homeManagerModules.desktop = {
    imports = with self.homeManagerModules; [
      brave
      catppuccin
      gtk
      qt
      vivaldi
      xdg
    ];
  };
}
