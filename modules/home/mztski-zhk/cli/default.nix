{ self, ... }: {
  flake.homeManagerModules.cli = {
    imports = with self.homeManagerModules; [
      git
      tmux
    ];
  };
}
