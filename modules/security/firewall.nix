{...}: {
  flake.nixosModules.firewall = {
    # <-- Firewall -->
    networking.nftables.enable = true;
    systemd.services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };
}
