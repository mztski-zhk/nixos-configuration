{ ... }: {
  flake.nixosModules.pipewire = {
    # <-- Audio pipewire/alsa/pulse -->
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # <-- Audio realtime toolkit -->
    security.rtkit.enable = true;
  };
}
