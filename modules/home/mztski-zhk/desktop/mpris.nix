{...}: {
  flake.homeModules.mpris = {
    services.mpris-proxy.enable = true;
  };
}
