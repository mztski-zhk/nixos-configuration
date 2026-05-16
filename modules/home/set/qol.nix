{ self, ... }: {
  # <-- modules that are improving quality of life, --> #
  # <-- while modules that are not hard required    --> #
  # <-- by desktops and servers                     --> #
  flake.homeModules.homeSetQol = {
    imports = with self.homeModules; [
      ai
    ];
  };
}
