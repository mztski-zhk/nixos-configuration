{ ... }: {
  flake.homeManagerModules.gtk = {
    gtk = {
      enabled = true;
    };
  };
}
