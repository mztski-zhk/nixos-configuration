{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: @surface0;
        border-radius: 12px;
        border: 2px solid @overlay0;
      }

      #workspaces button {
        padding: 0 10px;
        color: @text;
        background: transparent;
        border: none;
        border-radius: 8px;
        margin: 0 4px;
      }

      #workspaces button:hover {
        background: @surface1;
      }

      #workspaces button.focused {
        background: @mauve;
        color: @base;
      }

      #window {
        padding: 0 10px;
        color: @subtext0;
      }

      #clock {
        padding: 0 10px;
        color: @blue;
        font-weight: bold;
      }

      #pulseaudio {
        padding: 0 10px;
        color: @green;
      }

      #network {
        padding: 0 10px;
        color: @teal;
      }

      #cpu {
        padding: 0 10px;
        color: @red;
      }

      #memory {
        padding: 0 10px;
        color: @yellow;
      }

      #temperature {
        padding: 0 10px;
        color: @orange;
      }

      #battery {
        padding: 0 10px;
        color: @pink;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @peach;
      }

      #battery.critical:not(.charging) {
        color: @red;
        animation: blink 1s linear infinite;
      }

      @keyframes blink {
        to {
          color: @red;
        }
      }

      #tray {
        padding: 0 10px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
'';
  };
}