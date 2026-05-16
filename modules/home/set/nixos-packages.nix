{ ... }: {
  # temporary module, will be split into different modules
  flake.homeModules.homeSetNixosPackages = { pkgs, ... }: {
    home.packages = with pkgs; [
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
  };
}
