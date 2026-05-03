{ ... }: {
  flake.nixosModules.networking = {
    networking = {
      hostName = "nixos";
      networkmanager = {
        enable = true;
        insertNameservers = [ "100.100.10.1" "9.9.9.11" "1.1.1.2" ];
      };
    };
    time.timeZone = "Asia/Hong_Kong";
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
