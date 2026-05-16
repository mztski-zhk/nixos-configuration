{...}: {
  flake.nixosModules.networking = {
    networking = {
      hostName = "nixos";
      networkmanager = {
        enable = true;
      };
    };
    time.timeZone = "Asia/Hong_Kong";
    i18n.defaultLocale = "en_US.UTF-8";
    services.resolved = {
      enable = true;
      settings = {
        Resolve = {
          DNS = ["100.100.10.1"];
          FallbackDNS = ["9.9.9.11" "1.1.1.2"];
        };
      };
    };

    networking = {
      nameservers = ["127.0.0.1"];
      networkmanager.dns = "systemd-resolved";
    };
  };
}
