{...}: {
  flake.homeModules.tools = {pkgs, ...}: {
    home.packages = with pkgs; [
      tree
      nvtopPackages.full
      ripgrep
      fd
      gcc
      unzip
      gnutar
      p7zip
      websocat
      zenity
      ffmpeg
      fastfetch
      btop
      python3
      nodejs
      pinentry-all
      rbw
    ];
  };
}
