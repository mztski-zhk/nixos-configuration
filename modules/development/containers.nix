{ self, inputs, ... }: {
  flake.modules.nixos.development.containers = { pkgs, lib, ... }: {
    virtualisation = {
      containers.enable = true;
      oci-containers.backend = "podman";
      podman = {
        enable = true;
        autoPrune.enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
      containers.storage.settings = {
        storage = {
          driver = "btrfs";
          # runroot = "/run/containers/storage";
          # graphroot = "/var/lib/containers/storage";
        };
      };
      oci-containers = {
        containers = {
        };
      };
    };

    systemd.user.extraConfig = ''
DefaultEnvironment="PATH=/run/current-system/sw/bin:/run/wrappers/bin:${lib.makeBinPath [ pkgs.bash ]}"
'';
  };
}
