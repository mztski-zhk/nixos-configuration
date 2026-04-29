{
  flake.modules = {
    homeManager.utilities = { pkgs, ... }: {
      home.packages = with pkgs; [
        playerctl
        brightnessctl
        ddcutil
        wl-clipboard
        cliphist
        grim
        slurp
        yazi
        fuzzel
        awww
        cava
        ffmpeg
      ];
    };
  };
}