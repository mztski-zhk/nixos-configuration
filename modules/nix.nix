{ self, inputs, ... }: {
  flake.modules.nixos = {
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    nixpkgs.config.allowUnfree = true;
  };
}