{ config, ... }: {
  programs.waybar.settings.mainBar.cpu = {
    format = "{usage}% ";
    interval = 2;
    tooltip = true;
  };
}