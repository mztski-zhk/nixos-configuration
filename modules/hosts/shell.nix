{...}: {
  flake.nixosModules.shell = {
    config,
    pkgs,
    ...
  }: {
    environment.variables.EDITOR = "nvim";

    programs.zsh = {
      enable = true;
      enableLsColors = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        la = "ls -alFhXB --color=auto";
        ll = "ls -ltFhXB --color=auto";
        l = "ls -lFh --color=auto";
        lt = "ls -altFh";
        lx = "ls -lXB";

        v = "nvim";

        rebuild = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#nixos && cd -";
        update = "nix flake update && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
        nixos-clean = "sudo nix-collect-garbage --delete-older-than 7d";
        nixos-clean-all = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
        nixpkgs = "nh search --limit 7 | less";

        direnv-init = "cp /etc/nixos/templates/direnv/python/flake.nix . && cp /etc/nixos/templates/direnv/.envrc . && git init -b main . && git add . && direnv allow && git commit -m 'Direnv init'";
      };

      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      setOptions = [
        "HIST_IGNORE_ALL_DUPS"
      ];

      interactiveShellInit = ''
        export COLORTERM=truecolor

        export EDITOR="nvim"

        bindkey '^[[1;5C' forward-word
        bindkey '^[[1;5D' backward-word
      '';
    };
    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [zsh];
  };
}
