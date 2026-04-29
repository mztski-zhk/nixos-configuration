{
  flake.modules = {
    homeManager.security = { pkgs, ... }: {
      home.packages = with pkgs; [
        pinentry-all
        bitwarden-desktop
        rbw
      ];
    };
  };
}