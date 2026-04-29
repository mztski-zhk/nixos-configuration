{ self, inputs, ... }: {
  flake.nixosModules.features.ai = {
    claude-code = import ./claude-code.nix { inherit self inputs; };
  };
}
