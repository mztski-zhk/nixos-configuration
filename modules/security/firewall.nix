{ ... }: {
  flake.nixosModules.firewall = {
    # <-- Firewall -->
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [  ];
      allowedUDPPorts = [  ];
    };
  };
}
