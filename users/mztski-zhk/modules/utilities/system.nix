{
  flake.modules = {
    homeManager.utilities = { pkgs, ... }: {
      home.packages = with pkgs; [
        fastfetch
        btop
        nvtopPackages.full
      ];
    };
  };
}