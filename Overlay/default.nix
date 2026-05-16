{inputs, ...}: {
  flake.nixosModules.overlay = {
    imports = with inputs.nixosModules; [
      ov-llm-agent
    ];
  };
}
