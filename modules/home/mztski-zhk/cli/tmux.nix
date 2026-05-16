{...}: {
  flake.homeModules.tmux = {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      keyMode = "vi";
      clock24 = false;
      mouse = true;
      newSession = true;
      terminal = "ghostty";
      historyLimit = 9999;

      extraConfig = ''
        # change prefix
        unbind C-b
        set -g prefix C-a
        bind C-a send-prefix

        set -g default-terminal "tmux-256color"

        set -g renumber-windows on

        set -g allow-passthrough all
        set -g extended-keys on

        set -g set-clipboard on
        set -as terminal-features ',ghostty:clipboard'

        # Select on copy while not clearing selection
        bind -Tcopy-mode MouseDragEnd1Pane send -X copy-selection-no-clear
      '';
    };
  };
}
