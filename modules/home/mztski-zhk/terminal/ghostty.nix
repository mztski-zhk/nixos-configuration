{...}: {
  flake.homeModules.ghostty = {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      systemd.enable = true;
      settings = {
        theme = "catppuccin-macchiato";
        font-family = "Jetbrains Mono Nerd";

        background-blur = true;
        background-opacity = 0.75;
        background-blur-radius = 40;
      };
    };
  };
}
