{ ... }: {
  flake.nixosModules.sunshine = { pkgs, ... }: {
    # <-- Remote control -->
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      package = pkgs.sunshine.override { cudaSupport = true; };
    };
  };
}
