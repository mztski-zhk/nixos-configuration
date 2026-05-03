{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  home.username = "mztski-zhk";
  home.homeDirectory = "/home/mztski-zhk";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; 
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    gcc
    unzip
    gnutar
    p7zip

    websocat
    zenity

    pavucontrol
    blueman
    networkmanagerapplet

    playerctl
    brightnessctl
    ddcutil
    wireplumber

    wl-clipboard
    cliphist
    grim
    slurp

    yazi
    fuzzel

    awww
    cava

    ffmpeg

    fastfetch
    btop
    nvtopPackages.full

    python3
    nodejs

    pinentry-all # GnuPG
    rbw

    discord

    obsidian

    wireguard-tools
    proton-vpn
    proton-vpn-cli

    (prismlauncher.override {
    jdks = [
      zulu17
      zulu
      ];
    })
    (llama-cpp.override { cudaSupport = true; })
  ];
}
