{ ... }: {
  flake.nixosModules.apparmor = {
    security.apparmor = {
      enable = true;
      enableCache = true;
      killUnconfinedConfinables = true;
      packages = [
        pkgs.apparmor-parser
      ];
    };
  };
}
