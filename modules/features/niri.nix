{ self, inputs, ... }: {
  
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
    programs.waybar = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myWaybar;
    };

    programs.xwayland.enable = true;
  };

  perSystem = { pkgs, lib, self', ... }: {

    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {

        debug = {
          # Use amd to render niri 65:0:0:0
          render-drm-device = "/dev/dri/renderD128";
          # Ignore nvidia gpu 64:0:0:0
          ignore-drm-device = [ "/dev/dri/renderD129" ];
        };

        
        outputs."eDP-1" = {
          mode = "2560x1600@165";
          scale = 1.75;
        };
        
        input.touchpad = {
          natural-scroll = {};
          tap = {};
        };

        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
          (lib.getExe pkgs.xwayland-satellite)
          #{ "foot" "--server" };
          [ "niri" "msg" "action" "create-virtual-output" "--name" "'Virtual-1'"]

        ];

        input.keyboard = {
          xkb.layout = "us,ua";
          numlock = {};
        };
      
        layout = {
          gaps = 14;
        };


        binds = { 
          "Mod+Shift+Slash".show-hotkey-overlay = {};
          "Mod+Shift+S".screenshot-screen = {};
          "Mod+Shift+P".power-off-monitors = {};

          "Mod+F".maximize-column = {};
          "Mod+Ctrl+F".maximize-window-to-edges = {};
          "Mod+Shift+Ctrl+F".fullscreen-window = {};

          "Mod+T".spawn-sh = lib.getExe pkgs.alacritty;
          "Mod+D".spawn-sh = lib.getExe pkgs.fuzzel;
          "Mod+B".spawn-sh = "vivaldi";
          "Mod+Q".close-window = {};

          "Mod+H".focus-column-left = {};
          "Mod+J".focus-window-down = {};
          "Mod+K".focus-window-up = {};
          "Mod+L".focus-column-right = {};

          "Mod+Ctrl+H".move-column-right = {};
          "Mod+Ctrl+J".move-column-to-workspace-down = {};
          "Mod+Ctrl+K".move-column-to-workspace-up = {};
          "Mod+Ctrl+L".move-column-right = {};

          "Mod+Left".focus-column-left = {};
          "Mod+Down".focus-window-down = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Right".focus-column-right = {};

          "Mod+Ctrl+Left".move-column-left = {};
          "Mod+Ctrl+Down".move-column-to-workspace-down = {};
          "Mod+Ctrl+Up".move-column-to-workspace-up = {};
          "Mod+Ctrl+Right".move-column-right = {};

          "Mod+BracketLeft".consume-or-expel-window-left = {};
          "Mod+BracketRight".consume-or-expel-window-right = {};

          "Mod+C".center-column = {};
          "Mod+Ctrl+C".center-visible-columns = {};

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";

          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "Mod+Ctrl+V".toggle-window-floating = {};

          "XF86MonBrightnessUp".spawn = ["brightnessctl" "set" "+10%"]; 
          "XF86MonBrightnessDown".spawn = ["brightnessctl" "set" "10%-" ]; 

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
          "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          "XF86AudioPlay".spawn-sh = "playerctl play-pause";
          "XF86AudioStop".spawn-sh = "playerctl stop";
          "XF86AudioPrev".spawn-sh = "playerctl previous";
          "XF86AudioNext".spawn-sh = "playerctl next";
        };
      };
    };
    packages.myWaybar = inputs.wrapper-modules.wrappers.waybar.wrap {
      inherit pkgs;
      settings = {
        
      };
    };
  };
}
