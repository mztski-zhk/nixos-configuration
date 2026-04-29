{ config, ... }: {
  programs.waybar.settings.mainBar.pulseaudio = {
    format = "{volume}% {icon}";
    format-muted = "";
    format-icons = {
      default = ["" "" ""];
    };
    on-click = "pavucontrol";
  };
}