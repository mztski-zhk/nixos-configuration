{inputs, ...}: {
  flake.homeModules.catppuccin = {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
    ];

    catppuccin = {
      enable = true;
      flavor = "macchiato";
      cache.enable = true;

      cursors = {
        enable = true;
        accent = "blue";
      };

      cava = {
        enable = true;
        transparent = true;
      };

      swaylock = {
        enable = true;
        flavor = "mocha";
      };
      ghostty = {
        enable = true;
        flavor = "macchiato";
      };
    };
  };
}
