{ config, ... }: {
  programs.waybar.settings.mainBar."niri/window" = {
    format = "{}";
    max-length = 40;
    separate-outputs = true;
  };
}