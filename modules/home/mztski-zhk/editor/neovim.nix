{ ... }: {
  flake.homeManagerModules.neovim = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = false
    };
  };
}
