{ config, ... }: {
  programs.waybar.settings.mainBar.temperature = {
    critical-threshold = 80;
    format = "{temperatureC}°C {icon}";
    format-icons = ["" "" "" "" ""];
  };
}