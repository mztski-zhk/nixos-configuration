{ ... }: {
  flake.homeManagerModules.qt = {
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
  };
}
