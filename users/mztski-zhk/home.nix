{
  pkgs,
  config,
  inputs,
  ...
}: {
  home.username = "mztski-zhk";
  home.homeDirectory = "/home/mztski-zhk";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; 
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    terminal = "alacritty";

    extraConfig = ''
      set -g mouse on

      setw -g mode-keys vi

      set -g set-clipboard on
      set -as terminal-features ',alacritty:clipboard'
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "mztski-zhk";
        email = "mztski.zhk@gmail.com";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "macchiato";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "blue";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Macchiato-Dark-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };


  programs.alacritty = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
      vscode-icons-team.vscode-icons
      usernamehw.errorlens
      timonwong.shellcheck
      stylelint.vscode-stylelint
      rust-lang.rust-analyzer
      redhat.vscode-yaml
      redhat.ansible
      quicktype.quicktype
      prettier.prettier-vscode
      oderwat.indent-rainbow
      ms-vscode.remote-explorer
      ms-vscode.hexeditor
      ms-vscode.cpptools-extension-pack
      ms-vscode-remote.vscode-remote-extensionpack
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-containers
      ms-toolsai.jupyter
      ms-python.python
      ms-python.vscode-pylance
      ms-python.pylint
      ms-python.mypy-type-checker
      ms-python.isort
      ms-python.debugpy
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-azuretools.vscode-docker
      ms-azuretools.vscode-containers
      mechatroner.rainbow-csv
      leonardssh.vscord
      kamikillerto.vscode-colorize
      kamadorueda.alejandra
      ibm.output-colorizer
      github.vscode-pull-request-github
      github.vscode-github-actions
      github.github-vscode-theme
      github.copilot-chat
      github.copilot
      github.codespaces
      detachhead.basedpyright
      bierner.markdown-preview-github-styles
      bierner.markdown-mermaid
      bierner.github-markdown-preview
      bierner.docs-view
    ];
  };

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

  programs.vivaldi = {
    enable = true;
  };

  xdg = {
    autostart.enable = true;
    portal.config = {
      common = {
        default = [ "*" ];
      };
    };
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

    fastfetch
    btop
    nvtopPackages.full

    python3
    nodejs

    pinentry-all # GnuPG
    bitwarden-desktop
    rbw

    discord

    obsidian

    wireguard-tools
    proton-vpn
    proton-vpn-cli

    claude-code-router

    (prismlauncher.override {
    jdks = [
      zulu17
      zulu
      ];
    })
    (llama-cpp.override { cudaSupport = true; })
  ];

  home.stateVersion = "25.11";
}
