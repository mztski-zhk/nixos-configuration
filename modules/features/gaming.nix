{ self, inputs, ... }: {

  flake.nixosModules.gaming = { pkgs, lib, ... }: {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;
  };

  perSystem = { pkgs, ... }: {

    packages.myGaming = inputs.wrapper-modules.wrappers.myGaming.wrap {
      inherit pkgs;
      
      environment.systemPackages = with pkgs; [
        mongohud
        lutris
      ];
    };
  };
}
