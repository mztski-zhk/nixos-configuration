{ self, ... }: {
  flake.nixosModules.gaming = { pkgs, ... }: {
    imports = with self.nixosModules; [
      gamemode
      gamescope
      steam
    ];

    environment.systemPackages = with pkgs; [
      protontricks
      cabextract

      lsfg-vk
      lsfg-vk-ui

      mangohud
      goverlay
      lutris
      heroic
      protonup-qt
      winetricks
      wineWow64Packages.waylandFull
    ];
  };
}
