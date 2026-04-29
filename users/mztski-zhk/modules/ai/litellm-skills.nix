{ self, inputs, ... }: {
  flake.modules.homeManager.litellm-skills = { pkgs, config, ... }: {
    home.packages = with pkgs; [
      git
    ];

    home.file.".claude/skills/litellm-skills".source = pkgs.fetchFromGitHub {
      owner = "BerriAI";
      repo = "litellm-skills";
      rev = "faee92d57af1635c36b772422bec49d010ccb9ee";
      hash = "sha256-BQ5a+yipyRzP+GIalpWxhvwI50PudV2mv+s9pLkCY+E=";
    };

    home.activation.litellm-skills-symlinks = config.lib.dag.entryAfter ["writeBoundary"] ''
      SKILLS_DIR="${config.home.homeDirectory}/.claude/skills"
      INSTALL_DIR="$SKILLS_DIR/litellm-skills"

      mkdir -p "$SKILLS_DIR"

      for skill_dir in "$INSTALL_DIR"/*/; do
        if [ -d "$skill_dir" ]; then
          name=$(basename "$skill_dir")
          target="$SKILLS_DIR/$name"
          
          if [ -e "$target" ] && [ ! -L "$target" ]; then
            rm -rf "$target"
          fi
          
          if [ ! -e "$target" ]; then
            ln -sf "$skill_dir" "$target"
          fi
        fi
      done
    '';
  };
}
