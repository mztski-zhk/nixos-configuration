{...}: {
  flake.homeModules.fzf = {pkgs, ...}: {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    home.packages = with pkgs; [
      zsh-forgit
      zsh-fzf-history-search
      zsh-fzf-tab
    ];
  };
}
