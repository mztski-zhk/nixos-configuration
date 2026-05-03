{ ... }: {
  flake.nixosModules.nixSettings = {

    # <-- Enable exp. features(flake) -->
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # <-- Nix nixpkgs use cache -->
    nix.settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    # <-- Nix nixpkgs use unfree packages -->
    nixpkgs.config.allowUnfree = true;

    # <-- Nix Save Space -->
    nix.optimise.automatic = true;

    # <-- Reduce re-prompt -->
    nix.settings.trusted-users = [ "root" "mztski-zhk" ];
    
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
