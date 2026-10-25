{ self, ... }: {
  flake.nixosModules.remote = {
    imports = with self.nixosModules; [
      sunshine
      # rustdesk ## disabled, wayland not supported
    ];
  };
}
