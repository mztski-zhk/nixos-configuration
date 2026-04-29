{ config, ... }: {
  programs.waybar.settings.mainBar.network = {
    format-wifi = "{essid} ({signalStrength}%) ";
    format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
    format-disconnected = "Disconnected ⚠";
    tooltip-format = "{ifname}: {ipaddr}/{cidr}";
  };
}