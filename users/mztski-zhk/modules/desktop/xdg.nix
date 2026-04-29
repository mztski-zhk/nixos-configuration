{
  flake.modules = {
    homeManager.desktop = {
      xdg = {
        autostart.enable = true;
        portal.config = {
          common = {
            default = [ "*" ];
          };
        };
      };
    };
  };
}