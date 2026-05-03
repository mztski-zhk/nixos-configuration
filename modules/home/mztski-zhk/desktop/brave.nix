{ ... }: {
  flake.homeManagerModules.brave = { pkgs, ... }: {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;

      commandLineArgs = [
	"--ozone-platform-hint=auto"
	"--enable-features=WaylandWindowDecorations"
      ];

      extensions = [

      ];
    };
  };
}
