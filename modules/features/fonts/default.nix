{ ... }: {
  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji

        jetbrains-mono

        nerd-fonts.jetbrains-mono
        noto-fonts-cjk-sans
      ];
      fontconfig = {
        defaultFonts = {
          serif = ["Noto Serif"];
          sansSerif = ["Noto Sans"];
          monospace = ["JetBrainsMono Nerd Font"];
        };
      };
    };
  };
}
