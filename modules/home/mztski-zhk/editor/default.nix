{ self, ... }: {
  flake.homeManagerModules.editor = {
    imports = with self.homeManagerModules; [
      neovim
      vscode
      zed-editor
    ];
  };
}
