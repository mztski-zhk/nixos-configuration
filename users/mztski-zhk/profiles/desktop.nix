{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    desktop.gtk
    desktop.qt
    desktop.alacritty
    desktop.browsers
    desktop.xdg
    utilities.media
    utilities.system
  ];
}