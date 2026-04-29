{ self, inputs, ... }: {
  flake.modules.nixos.services.nginx = { pkgs, ... }: {
    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      appendHttpConfig = ''
        add_header 'Referrer-Policy' 'origin-when-cross-origin';
        add_header X-Frame-Options DENY;
        add_header X-Content-Type-Options nosniff;
      '';
      virtualHosts."mztski-zhk.cc" = {
        enableACME = false;
        forceSSL = false;
        locations."/" = {
          proxyPass = "http://127.0.0.1:80";
          proxyWebsockets = false;
          extraConfig =
            "proxy_ssl_server_name on;" +
            "proxy_pass_header Authorization;";
        };
      };
    };
  };
}