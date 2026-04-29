{
  flake.modules = {
    homeManager.development = {
      programs.tmux = {
        enable = true;
        clock24 = true;
        mouse = true;
        terminal = "alacritty";
        extraConfig = ''
          set -g mouse on
          setw -g mode-keys vi
          set -g set-clipboard on
          set -as terminal-features ',alacritty:clipboard'
        '';
      };
    };
  };
}