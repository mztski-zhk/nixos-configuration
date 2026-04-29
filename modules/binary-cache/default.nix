{ self, inputs, ... }: {
  flake.modules.nixos.binaryCache = {
    nix.settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3Wxa7aRdj6jgF4TWDqxKEyE44r2jQ5PrpHFgQWlDwq0="
        "devenv.cachix.org-1:w1cLUiFdvx2qL44Q6DB6q1go+D7Jr4bIqBqDQD/9nqg="
      ];
    };
  };
}