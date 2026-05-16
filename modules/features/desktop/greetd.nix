{ ... }: {
  flake.nixosModules.greetd = { pkgs, config, ... }: {
    # Enable greetd
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
        user = "mztski-zhk";
        command = "niri-session";
        };
        default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --remember-session --cmd niri-session";
        user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
