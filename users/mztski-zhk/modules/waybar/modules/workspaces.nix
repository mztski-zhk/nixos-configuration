{ config, ... }: {
  programs.waybar.settings.mainBar."niri/workspaces" = {
    disable-scroll = false;
    all-outputs = true;
    format = "{name}";
    format-icons = {
      active = "";
      default = "";
      urgent = "";
    };
  };
}