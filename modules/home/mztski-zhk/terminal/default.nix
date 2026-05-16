{ self, ... }: {
  flake.homeModules.terminal = {
    imports = with self.homeModules; [
      # alacritty
      ghostty
    ];
  };
}
