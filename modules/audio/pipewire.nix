{ self, inputs, ... }: {
  flake.modules.nixos.audio.pipewire = {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    security.rtkit.enable = true;
  };
}