{ ... }: {
  flake.homeModules.gtk = { pkgs, lib, ... }: {
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Macchiato-Standard-Blue-Dark";
        package = pkgs.catppuccin-gtk;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = lib.mkDefault pkgs.papirus-icon-theme;
      };

      font = {
        name = "Inter";
        size = 11;
      };
    };
  };
}
