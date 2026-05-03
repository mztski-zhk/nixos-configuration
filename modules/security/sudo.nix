{ ... }: {
  flake.nixosModules.sudo = {
    # <-- Security -->
    # Permission of podman rootful
    security.sudo.extraRules = [{
      users = [ "mztski-zhk" ];
      commands = [{
        command = "/run/current-system/sw/bin/podman";
        options = [ "NOPASSWD" ];
      }];
    }];
  };
}
