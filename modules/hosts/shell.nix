{ ... }: {
  flake.nixosModules.shell = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        la = "ls -alFhXB --color=auto";
        ll = "ls -ltFhXB --color=auto";
        l = "ls -lFh --color=auto";
        lt = "ls -altFh";
        lx = "ls -lXB";

        rebuild = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#nixos && cd -";
        update = "nix flake update && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
        nixos-clean = "sudo nix-collect-garbage --delete-older-than 7d";
        nixos-clean-all = "sudo nix-collect-garbage -d && nix-collect-garbage -d";

        direnv-init = "cp /etc/nixos/templates/direnv/python/flake.nix . && cp /etc/nixos/templates/direnv/.envrc . && git init -b main . && git add . && direnv allow && git commit -m 'Direnv init'";
        };

      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      setOptions = [
        "HIST_IGNORE_ALL_DUPS"
      ];
    };
    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [zsh];
  };
}
