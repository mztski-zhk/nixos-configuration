{ ... }: {
  flake.homeManagerModules.vivaldi = {
    programs.vivaldi = {
      enable = true;
    };
  };
}
