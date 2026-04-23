{ inputs, ... }: {
  imports = [
    ./claude-code.nix
    ./hermes-agent.nix
  ];
}
