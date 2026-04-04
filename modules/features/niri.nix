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
          scale = 1.5;
        };
        
        input.touchpad.natural-scroll = {};

        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
          (lib.getExe pkgs.xwayland-satellite)
          #{ "foot" "--server" };
        ];

        input.keyboard = {
          xkb.layout = "us,ua";
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

          "Mod+Ctrl+J".move-window-down-or-to-workspace-down = {};
          "Mod+Ctrl+K".move-window-up-or-to-workspace-up = {};

          "Mod+Shift+Ctrl+H".move-column-to-monitor-left = {};
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = {};
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = {};
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = {};

          "Mod+Left".focus-column-left = {};
          "Mod+Down".focus-window-down = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Right".focus-column-right = {};

          "Mod+Ctrl+Down".move-window-down-or-to-workspace-down = {};
          "Mod+Ctrl+Up".move-window-up-or-to-workspace-up = {};

          "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = {};
          "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = {};
          "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = {};
          "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = {};

          "Mod+BracketLeft".consume-or-expel-window-left = {};
          "Mod+BracketRight".consume-or-expel-window-right = {};

          #"XF86MonBrightnessUp".allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
          #"XF86MonBrightnessDown".{ spawn "brightnessctl" "--class=backlight" "set" "10%-"; }
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
