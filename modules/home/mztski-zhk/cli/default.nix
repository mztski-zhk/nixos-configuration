{self, ...}: {
  # <-- nesscessary CLI tools and utilities --> #
  # <-- that are required by all mechines   --> #
  flake.homeModules.cli = {
    imports = with self.homeModules; [
      git
      bat
      tmux
      tools
    ];
  };
}
