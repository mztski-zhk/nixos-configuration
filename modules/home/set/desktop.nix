{ self, ... }: {
  flake.homeModules.homeSetDesktop = {
    # <-- Desktop environment and GUI tools,         --> #
    # <-- probably not hard required by all machines --> #
    imports = with self.homeModules; [
      desktop
      guiEditors
      # desktopApps idk what is this, but suggest by AI
      terminal
    ];
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
