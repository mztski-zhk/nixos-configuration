{self, ...}: {
  # <-- AI tools, not hard requirement -->
  flake.homeModules.ai = {
    imports = with self.homeModules; [
      # tools
      pi-agent
      skills
    ];
  };
}
