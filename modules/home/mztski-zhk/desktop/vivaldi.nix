{ ... }: {
  flake.homeModules.vivaldi = {
    programs.vivaldi = {
      enable = true;
    };
  };
}
