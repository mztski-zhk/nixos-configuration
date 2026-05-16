{ self, ... }: {
  # <-- define tui editors -->
  flake.homeModules.tuiEditors = {
    imports = with self.homeModules; [
      nvf
    ];
  };

  # <-- define gui editors -->
  flake.homeModules.guiEditors = {
    imports = with self.homeModules; [
      vscode
      zed-editor
    ];
  };
}
