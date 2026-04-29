{ config, ... }: {
  programs.waybar.settings.mainBar.memory = {
    format = "{}% ";
    interval = 2;
    tooltip-format = "{used:0.1f}GB / {total:0.1f}GB";
  };
}