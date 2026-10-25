{...}: {
  flake.nixosModules.podman = {
    lib,
    pkgs,
    ...
  }: {
    # Nvidia Container Toolkit
    hardware.nvidia-container-toolkit.enable = true;

    # Enable podman
    virtualisation = {
      containers = {
        enable = true;
        storage.settings = {
          storage = {
            driver = "btrfs";
            runroot = "/run/containers/storage";
            graphroot = "/var/lib/containers/storage";
            options.overlay.mountopt = "nodev,metacopy=on";
          };
        };
      };

      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      oci-containers = {
        backend = "podman";
      };
    };

    # Required for Rootless podman.
    systemd.user.extraConfig = ''
      DefaultEnvironment="PATH=/run/current-system/sw/bin:/run/wrappers/bin:${lib.makeBinPath [pkgs.bash]}"
    '';

    environment.systemPackages = with pkgs; [
      dive # look into docker image layers
      podman-tui # status of containers in the terminal
      docker-compose # start group of containers for dev
      # podman-compose # start group of containers for dev
      passt
    ];
  };
}
