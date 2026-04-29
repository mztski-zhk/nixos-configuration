{
  flake.modules = {
    homeManager.utilities = { pkgs, ... }: {
      home.packages = with pkgs; [
        ripgrep
        fd
        gcc
        unzip
        gnutar
        p7zip
        websocat
        zenity
      ];
    };
  };
}