{ self, inputs, ... }: {
  flake.modules.nixos.services.remote-control = {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
    };
  };
}