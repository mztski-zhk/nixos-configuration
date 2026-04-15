{ self, inputs, ... }: {

  flake.nixosModules.gaming = { pkgs, lib, ... }: {
    
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.gamemode.enable = true;

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

