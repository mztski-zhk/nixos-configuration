{ ... }: {
  flake.nixosModules.starship = {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
      };
    };
  };
}
