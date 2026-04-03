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

  programs.alacritty = {
    enable = true;
  };

#   programs.foot = {
#     enable = true;
#     settings = {
#       
#       # Keep your font settings from earlier!
#       main = {
#         font = "JetBrainsMono Nerd Font:size=12,monospace:size=12"; 
#         pad = "15x15 center";
#       };
# 
#       # Tokyo Night Storm Palette
#       colors-dark = {
#         alpha = "0.75";
#         background = "24283b";
#         foreground = "c0caf5";
# 
#        # Normal colors (0-7)
#        regular0 = "1d202f"; # black
#        regular1 = "f7768e"; # red
#        regular2 = "9ece6a"; # green
#        regular3 = "e0af68"; # yellow
#        regular4 = "7aa2f7"; # blue
#        regular5 = "bb9af7"; # magenta
#        regular6 = "7dcfff"; # cyan
#        regular7 = "a9b1d6"; # white

        # Bright colors (8-15)
#        bright0 = "414868"; # bright black
#        bright1 = "f7768e"; # bright red
#        bright2 = "9ece6a"; # bright green
#        bright3 = "e0af68"; # bright yellow
#        bright4 = "7aa2f7"; # bright blue
#        bright5 = "bb9af7"; # bright magenta
#        bright6 = "7dcfff"; # bright cyan
#        bright7 = "c0caf5"; # bright white
#      };
#    };
#  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    terminal = "foot";

    # Ensure clipboard works in Wayland
    extraConfig = ''
      set -g mouse on

      setw -g mode-keys vi

      set -g set-clipboard on
      set -as terminal-features ',foot:clipboard'
    '';
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
      vscodevim.vim
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

  programs.keepassxc = {
    autostart = true;
    enable = true;
    settings = {
      FdoSecrets.Enabled = true; # Enable Secret Service Integration
    };
  };

  xdg.autostart.enable = true; # Enable creation of XDG autostart entries.

  home.packages = with pkgs; [
    vivaldi

    ripgrep
    fd
    gcc
    unzip

    brightnessctl
    ddcutil

    foot.terminfo
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

    python3
    nodejs

    (prismlauncher.override {
    jdks = [
      zulu17
      zulu
      ];
    })
  ];

  home.stateVersion = "25.11";
}
