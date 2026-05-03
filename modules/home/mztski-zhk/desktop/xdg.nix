{ ... }: {
  flake.homeManagerModules.xdg = {
    xdg = {
      autostart.enable = true;
      portal.config = {
        common = {
          default = [ "*" ];
        };
      };
    };
  };
}
