{ ... }: {
  flake.nixosModules.sunshine = {
    # <-- Remote control -->
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
    };
  };
}
