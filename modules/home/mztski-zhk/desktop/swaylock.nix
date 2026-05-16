{...}: {
  flake.homeModules.swaylock = {
    pkgs,
    lib,
    ...
  }: {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 100;
        indicator-thickness = 7;
        show-failed-attempts = true;
      };
    };
  };
}
