{ ... }: {
  flake.nixosModules.apparmor = { pkgs, ... }: {
    security.apparmor = {
      enable = true;
      enableCache = true;
      killUnconfinedConfinables = true;
      packages = [
        pkgs.apparmor-parser
      ];
    };
    services.dbus.apparmor = "enabled";
  };
}
