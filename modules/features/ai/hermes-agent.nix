{ inputs, ... }: {

  # Hermes Agent
  services.hermes-agent = {
    enable = true;
    container.enable = true;
    container.hostUsers = [ "mztski-zhk" ];
    environmentFiles = [ "/etc/nixos/secrets/hermes-agent" ];
    addToSystemPackages = true;
    settings = {
      model.default = "anthropic/claude-sonnet-4";
      toolsets = [ "all" ];
      terminal = { backend = "local"; timeout = 180; };

      # Personality
      display = { compact = false; personality = "kawaii"; };
      memory = { memory_enabled = true; user_profile_enabled = true; };
    };
  };



}
