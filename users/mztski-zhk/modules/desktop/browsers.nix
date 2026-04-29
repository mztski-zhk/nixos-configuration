{
  flake.modules = {
    homeManager.desktop = { pkgs, ... }: {
      programs.chromium = {
        enable = true;
        package = pkgs.brave;
        commandLineArgs = [
          "--ozone-platform-hint=auto"
          "--enable-features=WaylandWindowDecorations"
        ];
        extensions = [];
      };
      programs.vivaldi = {
        enable = true;
      };
    };
  };
}