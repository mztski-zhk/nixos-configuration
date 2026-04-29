{ self, inputs, ... }: {
  flake.modules.nixos = {
    networking = {
      hostName = "nixos";
      networkmanager.enable = true;
      networkmanager.insertNameservers = [ "100.100.10.1" ];
    };
    time.timeZone = "Asia/Hong_Kong";
    i18n.defaultLocale = "en_US.UTF-8";

    # port forwarding
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
    };
  };
}
