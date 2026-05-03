{ ... }: {
  flake.nixosModules.waybar = {
    programs.waybar = {
      enable = true;
      settings = {

      };
    };
  };
}
