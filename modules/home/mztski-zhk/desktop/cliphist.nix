{ ... }: {
  flake.homeModules.cliphist = {

    services.cliphist = {

      enable = true;

      # A Wayland session
      systemdTargets = ["config.wayland.systemd.target"];
      extraOptions = [
        "-max-dedupe-search"
        "10"
        "-max-items"
        "500"
      ];
      allowImages = true;
    };
  };
}
