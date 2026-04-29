{ config, ... }:
{
  flake.modules.homeManager.development.imports = with config.flake.modules.homeManager; [
    development.direnv
    development.tmux
    development.git
    development.neovim
    development.vscode
    development.languages
  ];
}