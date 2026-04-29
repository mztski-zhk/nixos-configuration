{ config, ... }:
{
  flake.modules.homeManager.full.imports = with config.flake.modules.homeManager; [
    profiles.base
    profiles.development
    profiles.desktop
    security.gpg
    security.vpn
    communication.discord
    productivity.obsidian
ai.claude
  gaming.minecraft
  ];
}