{ self, input, ... }: {
  systems = ["x86_64-linux"];
  flake.modules.nixos.services.postgresql = {
    pkgs,
    lib,
    ...
  }: {
    config.services.postgresql = {
      enable = true;
      ensureDatabases = [ "db" ];
      authentication = pkgs.lib.mkOverride 10 ''
#type database DBuser auth-method
local all all trust
      '';
      settings = {
        port = 5432;
      };
    };
  };
}

