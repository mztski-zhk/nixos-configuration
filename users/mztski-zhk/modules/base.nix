{
  flake.modules = {
    homeManager.base = {
      home.username = "mztski-zhk";
      home.homeDirectory = "/home/mztski-zhk";
      home.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
      home.stateVersion = "25.11";
    };
  };
}