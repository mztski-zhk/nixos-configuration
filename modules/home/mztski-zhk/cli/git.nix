{ ... }: {
  flake.homeModules.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name  = "mztski-zhk";
          email = "mztski.zhk@gmail.com";
        };

        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
  };
}
