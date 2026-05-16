{...}: {
  flake.homeModules.skills = {pkgs, ...}: {
    home.packages = with pkgs.llm-agents; [
      skills
    ];
  };
}
