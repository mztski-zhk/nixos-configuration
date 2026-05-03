{ self, ... }: {
  flake.nixosModules.hosts = { pkgs, ... }: {
    imports = with self.nixosModules; [
      asus
      boot
      dbus
      driver
      hardware
      impermanence
      networking
      shell
      ssh
      starship
      vpn
    ];

    # <-- System Packages -->
    environment.systemPackages = with pkgs; [
      vim
      pciutils
      btrfs-progs
      sops
      git
      wget
      curl
      jq

      openssl

      xwayland-satellite
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome

      tailscale
    ];
  };
}
