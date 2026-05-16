{ inputs, ... }: {
  flake.nixosModules.nixOverlays = {
    nixpkgs.overlays = [
      (import ../../Overlay/llm-agents.nix { inherit inputs; })
    ];
  };
}
