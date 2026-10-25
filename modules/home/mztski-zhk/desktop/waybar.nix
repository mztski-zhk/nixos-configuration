{lib, ...}: let
  palette = {
    base = "#24273a";
    mantle = "#1e2030";
    crust = "#181926";
    surface0 = "#363a4f";
    surface1 = "#494d64";
    surface2 = "#5b6078";
    overlay0 = "#6e738d";
    overlay1 = "#8087a2";
    overlay2 = "#939ab7";
    text = "#cad3f5";
    subtext0 = "#a5adcb";
    subtext1 = "#b8c0e0";
    blue = "#8aadf4";
    sapphire = "#7dc4e4";
    teal = "#8bd5ca";
    green = "#a6da95";
    yellow = "#eed49f";
    peach = "#f5a97f";
    red = "#ed8796";
    pink = "#f5bde6";
  };
  toCSS = styles:
    lib.concatStringsSep "\n\n" (
      lib.mapAttrsToList (
        selector: props: let
          propLines = lib.concatStringsSep "\n" (
            lib.mapAttrsToList (name: value: "  ${name}: ${value};") props
          );
        in "${selector} {\n${propLines}\n}"
      )
      styles
    );
  groupPill = {
    "background-color" = palette.surface0;
    color = palette.text;
    padding = "4px 10px";
    "border-radius" = "999px";
    border = "1px solid ${palette.surface2}";
    "box-shadow" = "inset 0 0 0 1px rgba(36, 39, 58, 0.65)";
  };
  groupInner = {
    "background-color" = "transparent";
    border = "none";
    "box-shadow" = "none";
    padding = "0 6px";
    "min-height" = "24px";
  };
  style = {
    "*" = {
      border = "none";
      "min-height" = "0";
    };

    "window#waybar" = {
      "background-color" = "rgba(36, 39, 58, 0.7)";
      color = palette.text;
      "border-radius" = "18px";
      margin = "8px 10px";
      padding = "8px 12px";
      border = "1px solid rgba(91, 96, 120, 0.85)";
      "box-shadow" = "0 10px 28px rgba(24, 25, 38, 0.45)";
    };

    "window#waybar.empty" = {
      background = "transparent";
      border = "none";
      "box-shadow" = "none";
    };

    tooltip = {
      background = palette.mantle;
      color = palette.text;
      "border-radius" = "12px";
      border = "1px solid ${palette.surface1}";
    };

    "tooltip label" = {
      padding = "6px 8px";
    };

    ".modules-left > widget" = {
      margin = "0 4px";
    };

    ".modules-center > widget" = {
      margin = "0 4px";
    };

    ".modules-right > widget" = {
      margin = "0 4px";
    };

    ".module" = {
      "background-color" = palette.surface0;
      color = palette.text;
      padding = "4px 12px";
      "border-radius" = "999px";
      border = "1px solid ${palette.surface2}";
      "box-shadow" = "inset 0 0 0 1px rgba(36, 39, 58, 0.65)";
      "min-height" = "24px";
      "min-width" = "24px";
    };

    "#clock" = groupPill;
    "#system" = groupPill;
    "#media" = groupPill;
    "#tray-group" = groupPill;
    "#connect" = groupPill;
    "#power" = groupPill;

    "#clock .module" = groupInner;
    "#system .module" = groupInner;
    "#media .module" = groupInner;
    "#tray-group .module" = groupInner;
    "#connect .module" = groupInner;
    "#power .module" = groupInner;

    "#media #pulseaudio-slider" = {
      "background-color" = "transparent";
      border = "none";
      "box-shadow" = "none";
      padding = "0 8px";
      "min-width" = "70px";
    };

    "#tray-group #tray" = {
      "background-color" = "transparent";
      border = "none";
      "box-shadow" = "none";
      padding = "0 6px";
    };

    "#workspaces" = {
      background = palette.surface0;
      padding = "2px 6px";
      border = "1px solid ${palette.surface2}";
      "border-radius" = "999px";
      "box-shadow" = "inset 0 0 0 1px rgba(36, 39, 58, 0.65)";
    };

    "#workspaces button" = {
      padding = "2px 8px";
      margin = "0 3px";
      "border-radius" = "999px";
      background = palette.surface1;
      color = palette.subtext0;
      border = "1px solid ${palette.surface2}";
      "box-shadow" = "inset 0 0 0 1px rgba(36, 39, 58, 0.55)";
    };

    "#workspaces button.active" = {
      background = palette.blue;
      color = palette.crust;
      "border-color" = palette.blue;
    };

    "#workspaces button.urgent" = {
      background = palette.red;
      color = palette.crust;
      "border-color" = palette.red;
    };

    "#workspaces button:hover" = {
      background = palette.surface2;
      color = palette.text;
    };

    "#pulseaudio-slider" = {
      "background-color" = palette.surface0;
      color = palette.text;
      padding = "4px 12px";
      "border-radius" = "999px";
      border = "1px solid ${palette.surface2}";
      "box-shadow" = "inset 0 0 0 1px rgba(36, 39, 58, 0.65)";
      "min-width" = "80px";
    };

    "#pulseaudio-slider trough" = {
      background = palette.surface1;
      "border-radius" = "999px";
      "min-height" = "6px";
    };

    "#pulseaudio-slider highlight" = {
      background = palette.blue;
      "border-radius" = "999px";
    };

    "#pulseaudio-slider slider" = {
      background = palette.blue;
      "border-radius" = "999px";
      "min-width" = "12px";
      "min-height" = "12px";
      margin = "-3px 0";
      "box-shadow" = "0 0 0 2px rgba(36, 39, 58, 0.65)";
    };

    "#pulseaudio.muted" = {
      color = palette.overlay1;
    };

    "#pulseaudio.microphone-muted" = {
      color = palette.overlay1;
    };

    "#bluetooth.disabled" = {
      color = palette.overlay1;
    };

    "#network.disconnected" = {
      color = palette.overlay1;
    };

    "#battery.charging" = {
      background = palette.green;
      color = palette.crust;
      "border-color" = palette.green;
    };

    "#battery.critical" = {
      background = palette.red;
      color = palette.crust;
      "border-color" = palette.red;
    };

    "#idle_inhibitor.activated" = {
      background = palette.teal;
      color = palette.crust;
      "border-color" = palette.teal;
    };
  };
in {
  flake.homeModules.waybar = {
    programs.waybar = {
      enable = true;
      style = toCSS style;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 36;
          spacing = 8;
          exclusive = true;

          # -------------------------------------------------------------------------
          # LAYOUT DEFINITION
          # -------------------------------------------------------------------------
          modules-left = [
            "custom/launcher"
            "group/clock"
            "group/system"
            "niri/window"
            "niri/workspaces"
          ];
          modules-center = ["cava"];
          modules-right = [
            "group/media"
            "group/tray-group"
            "group/connect"
            "group/power"
          ];

          # -------------------------------------------------------------------------
          # GROUP MODULES
          # -------------------------------------------------------------------------
          "group/clock" = {
            orientation = "horizontal";
            modules = [
              "clock#time"
              "clock#date"
            ];
          };

          "group/system" = {
            orientation = "horizontal";
            modules = [
              "cpu"
              "temperature"
              "memory"
              "disk"
            ];
          };

          "group/media" = {
            orientation = "horizontal";
            modules = [
              "mpris"
              "pulseaudio"
              "pulseaudio#microphone"
            ];
          };

          "group/tray-group" = {
            orientation = "horizontal";
            modules = [
              "custom/tray-arrow"
              "tray"
            ];
          };

          "group/connect" = {
            orientation = "horizontal";
            modules = [
              "bluetooth"
              "network"
            ];
          };

          "group/power" = {
            orientation = "horizontal";
            modules = [
              "backlight"
              "idle_inhibitor"
              "dynamic-search"
              "power-profiles-daemon"
              "battery"
              "custom/power"
            ];
          };

          # -------------------------------------------------------------------------
          # LEFT MODULES
          # -------------------------------------------------------------------------
          "custom/launcher" = {
            format = "";
            tooltip = false;
            on-click = "fuzzel";
          };

          "clock#time" = {
            format = "{:%e:%M}";
            min-length = 5;
            max-length = 5;
            tooltip-format = "<b>Standard Time</b>: <span text_transform='lowercase'>{:%I:%M %p}</span>";
          };

          "clock#date" = {
            format = "󰸗 {:%m-%d}";
            min-length = 8;
            max-length = 8;
            tooltip-format = "{calendar}";
            calendar = {
              mode = "month";
              mode-mon-col = 6;
              format = {
                months = "<span alpha='100%'><b>{}</b></span>";
                days = "<span alpha='90%'>{}</span>";
                weekdays = "<span alpha='80%'><i>{}</i></span>";
                today = "<span alpha='100%'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click = "mode";
            };
          };

          cpu = {
            tooltip = true;
            interval = 10;
            format = "󰻠 {usage}%";
            format-alt = "󰻠 <span size='11pt'>{usage}%</span>";
            states = {
              warning = 75;
              critical = 90;
            };
          };

          temperature = {
            tooltip = true;
            interval = 10;
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-critical = "󰀦 {temperatureC}°C";
            format-icons = [
              ""
              ""
              ""
            ];
          };

          memory = {
            tooltip = "Memory Used: {used:0.0f}/{total:0.0f} GiB";
            interval = 15;
            format = "󰍛 {percentage}%";
            format-alt = "󰍛 <span size='11pt'>{used}</span>";
            states = {
              warning = 75;
              critical = 85;
            };
          };

          disk = {
            tooltip = false;
            interval = 3600;
            path = "/";
            format = "󱙋 {percentage_used}%";
            format-alt = "󱙋 <span size='11pt'>{used}</span>";
            states = {
              warning = 80;
              critical = 90;
            };
          };

          "niri/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              urgent = "";
              active = "";
              default = "";
            };
          };

          "niri/window" = {
            format = "{}";
            max-length = 16;
            rewrite = {
            };
          };

          # -------------------------------------------------------------------------
          # CENTER MODULES
          # -------------------------------------------------------------------------
          cava = {
            framerate = 30;
            autosens = 1;
            bars = 14;
            lower_cutoff_freq = 50;
            higher_cutoff_freq = 10000;
            method = "pipewire";
            source = "auto";
            stereo = true;
            reverse = false;
            bar_delimiter = 0;
            monstercat = false;
            waves = false;
            noise_reduction = 0.77;
            input_delay = 2;
            format-icons = [" " "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          };

          # -------------------------------------------------------------------------
          # RIGHT MODULES
          # -------------------------------------------------------------------------

          mpris = {
            format = "{player_icon} {title} - {artist}";
            format-paused = "{status_icon} {title} - {artist}";
            tooltip-format = "Playing: {title} - {artist}";
            tooltip-format-paused = "Paused: {title} - {artist}";
            player-icons = {
              default = "󰐊";
            };
            status-icons = {
              paused = "󰏤";
            };
            max-length = 16;
          };

          "custom/tray-arrow" = {
            format = "{icon}";
            tooltip = false;
            format-icons = {
              notification = "󱅫";
              none = "󰏖";
              dnd-notification = "󰂠";
              dnd-none = "󰪓";
              inhibited-notification = "󰂛";
              inhibited-none = "󰪑";
              dnd-inhibited-notification = "󰂛";
              dnd-inhibited-none = "󰪑";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb 2>/dev/null";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };

          tray = {
            icon-size = 16;
            spacing = 10;
            show-passive-items = false;
            icons = {
            };
          };

          "custom/asusctl" = {
            format = "{icon}";
            format-icons = {
              turbo = "󰓅";
              performance = "";
              balanced = "󰶘";
              quiet = "";
              default = "󰈐";
            };
            interval = 2;
            return-type = "json";
            exec = "asusctl profile get | sed 's/Active profile is //' | awk '{ profile=$0; p=tolower($0); class=\"default\"; if (p ~ /turbo/) class=\"turbo\"; else if (p ~ /performance/) class=\"performance\"; else if (p ~ /balanced/) class=\"balanced\"; else if (p ~ /quiet|silent|eco|power/) class=\"quiet\"; printf \"{\\\"text\\\":\\\"%s\\\",\\\"class\\\":\\\"%s\\\"}\\n\", profile, class; }' 2>/dev/null";
            on-click = "asusctl profile next";
            tooltip = "asusctl profile list | sed 'Profile avaliable: //'";
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "{icon} {volume}%";
            format-icons = {
              default = ["󰕿" "󰖀" "󰕾"];
              default-muted = "󰝟";
              headphone = "󰋋";
              headphone-muted = "󰟎";
              headset = "󰋎";
              headset-muted = "󰋐";
            };
            on-click = "pavucontrol";
            tooltip-format = "Output: {volume}%";
          };

          "pulseaudio#microphone" = {
            format = "{format_source}";
            format-source = "";
            format-source-muted = "";
          };

          bluetooth = {
            format = "󰂯";
            format-connected = "󰂱";
            format-disabled = "󰂲";
            tooltip-format = "{controller_alias} {status}";
            tooltip-format-connected = "󰐻  {num_connections} Connected:\n{device_enumerate}";
            tooltip-format-enumerate-connected-battery = "󰂱  {device_alias} (󰠠  {device_battery_percentage}%)";
            on-click = "blueman-manager";
            on-click-right = "rfkill toggle bluetooth";
          };

          network = {
            format-wifi = "{icon}";
            format-ethernet = "";
            format-linked = "󱘖";
            format-disconnected = "󰤣";
            format-disabled = "󰤮";
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            tooltip-format-disconnected = "No Connection";
            tooltip-format-disabled = "Wi-Fi is OFF";
            tooltip-format-wifi = "󱄙  {essid} ({signalStrength}%)\n\n󰐻  Freq: {frequency}GHz\n  {bandwidthDownBytes}   {bandwidthUpBytes}";
            tooltip-format-ethernet = "󰈀  {ifname} (Connected)\n  {bandwidthDownBytes}   {bandwidthUpBytes}";
            tooltip-format-linked = "󱘖 {ifname}: No IP Address";
            on-click = "nm-applet --indicator";
            on-click-right = "pkill nm-applet";
            on-scroll-up = "nmcli radio wifi on";
            on-scroll-down = "nmcli radio wifi off";
          };

          backlight = {
            device = "nvidia_0";
            format = "{icon} {percent}%";
            format-icons = ["󰃞" "󰃟" "󰃠"];
            on-scroll-up = "brightnessctl set +1";
            on-scroll-down = "brightnessctl set 1-";
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "󰛨";
              deactivated = "󰛩";
            };
            tooltip-format-activated = "Caffeine Mode: Active";
            tooltip-format-deactivated = "Caffeine Mode: Inactive";
          };

          power-profiles-daemon = {
            format = "{icon}";
            tooltip-format = "󰓅   {profile}\n󰒓   {driver}";
            format-icons = {
              default = "";
              performance = "";
              balanced = "󰶘";
              power-saver = "";
            };
          };

          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} <span size='11pt'>{capacity}%</span>";
            format-full = "{icon} <span size='11pt'>{capacity}%</span>";
            format-charging = "<span size='12pt'>󱐌</span> <span size='11pt'>{capacity}%</span>";
            format-plugged = " <span size='11pt'>{capacity}%</span>";
            format-alt = "{icon} <span size='11pt'>{time}</span>";
            tooltip-format = "{timeTo}\n\n󰠠  Usage: {power:0.1f}W\n󱤅  Condition: {health}%\n󱍸  Total: {cycles} cycles";
            format-icons = {
              default = [
                "󰂎"
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
          };

          "custom/power" = {
            format = "⏻ ";
            tooltip = false;
            on-click = "wlogout -b 2 -c 0 -r 0 -m 400";
          };
        };
      };
    };
  };
}
