{...}: {
  flake.nixosModules.sunshine = {pkgs, ...}: {
    # <-- Remote control -->
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      package = pkgs.sunshine.override {cudaSupport = true;};
    };

    systemd.user.services.sunshine.serviceConfig.LimitNOFILE = 524288;

    hardware.uinput.enable = true;

    services.udev.packages = [pkgs.sunshine];

    boot.kernel.sysctl = {
      "fs.file-max" = 524288;
    };

    systemd.settings.Manager.DefaultLimitNOFILE = 524288;

    security.pam.loginLimits = [
      {
        domain = "*";
        type = "soft";
        item = "nofile";
        value = "8192";
      }
      {
        domain = "*";
        type = "hard";
        item = "nofile";
        value = "524288";
      }
    ];
  };
}
