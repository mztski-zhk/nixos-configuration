{...}: {
  flake.homeModules.fzf = {pkgs, ...}: {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    home.packages = with pkgs; [
      zsh-forgit
      zsh-fzf-history-search
    ];
  };
}
