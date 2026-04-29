{ self, inputs, ... }: {
  flake.modules.nixos.services.vpn = {
    services.tailscale.enable = true;
  };
}