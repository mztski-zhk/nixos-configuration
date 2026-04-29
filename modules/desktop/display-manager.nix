{ self, inputs, ... }: {
  flake.modules.nixos.desktop.display-manager = { pkgs, ... }: {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd niri-session";
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
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}