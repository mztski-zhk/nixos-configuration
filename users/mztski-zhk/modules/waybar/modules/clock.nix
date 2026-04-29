{ config, ... }: {
  programs.waybar.settings.mainBar.clock = {
    format = "{:%H:%M}";
    format-alt = "{:%Y-%m-%d %H:%M:%S}";
    tooltip-format = "<tt><small>{calendar}</small></tt>";
    calendar = {
      mode = "year";
      mode-mon-col = 3;
      weeks-pos = "right";
      format = {
        months = "<span color='#ff79c6'><b>{}</b></span>";
        days = "<span color='#f8f8f2'>{}</span>";
        weeks = "<span color='#50fa7b'>W{}</span>";
        weekdays = "<span color='#ff79c6'>{}</span>";
        today = "<span color='#ff5555'><b><u>{}</u></b></span>";
      };
    };
    actions = {
      on-click-right = "mode";
      on-click-forward = "tz_up";
      on-click-backward = "tz_down";
    };
  };
}