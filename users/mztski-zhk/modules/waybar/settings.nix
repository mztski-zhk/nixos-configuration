{ config, ... }: {
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 35;
      spacing = 0;
      margin-top = 5;
      margin-left = 10;
      margin-right = 10;
      
      modules-left = [
        "niri/workspaces"
        "niri/window"
      ];
      
      modules-center = [
        "clock"
      ];
      
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "tray"
      ];
    };
  };
}