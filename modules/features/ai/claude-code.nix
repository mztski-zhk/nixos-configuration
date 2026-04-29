{ self, inputs, ... }: {
  flake.nixosModules.features.ai.claude-code = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      inputs.claude-code.packages.${pkgs.system}.default
    ];
  };
}
