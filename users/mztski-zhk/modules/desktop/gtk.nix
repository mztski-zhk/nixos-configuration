{
  flake.modules = {
    homeManager.desktop = { pkgs, ... }: {
      gtk = {
        enable = true;
        theme = {
          name = "Catppuccin-Macchiato-Standard-Blue-Dark";
          package = pkgs.catppuccin-gtk.override {
            accents = [ "blue" ];
            size = "standard";
            variant = "macchiato";
          };
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.catppuccin-papirus-folders.override {
            flavor = "macchiato";
            accent = "blue";
          };
        };
        cursorTheme = {
          name = "Catppuccin-Macchiato-Dark-Cursors";
          package = pkgs.catppuccin-cursors.macchiatoDark;
        };
      };
    };
  };
}