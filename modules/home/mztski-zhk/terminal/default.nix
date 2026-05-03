{ self, ... }: {
  flake.homeManagerModules.terminal = {
    imports = with self.homeManagerModules;[
      alacritty
    ];
  };
}
