{ ... }: {
  flake.nixosModules.gamescope = {
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
