{ self, inputs, ... }: {
  flake.modules.nixos.development.tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vim
      pciutils
      btrfs-progs
      openssl
      git
      wget
      curl
      jq
      sops
      xwayland-satellite
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      tailscale
      dive
      podman
      podman-tui
      passt
      uv
    ];
  };
}
