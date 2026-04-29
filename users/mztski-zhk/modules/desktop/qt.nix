{
  flake.modules = {
    homeManager.desktop = {
      qt = {
        enable = true;
        platformTheme = "qtct";
        style.name = "kvantum";
      };
    };
  };
}