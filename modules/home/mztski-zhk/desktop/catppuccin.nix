{ inputs, ... }: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    cache.enable = true;

    cursors = {
	enable = true;
	accent = "lavender";
    };

    cava = {
	enable = true;
	transparent = true;
    };
  };
}
