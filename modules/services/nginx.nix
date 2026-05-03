{ ... }: {
  flake.nixosModules.nginx = {
    # <-- Nginx -->
    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      appendHttpConfig = ''
        # Enable content policy
        add_header 'Referrer-Policy' 'origin-when-cross-origin';

        # Disable embedding as a frame
        add_header X-Frame-Options DENY;

        # Prevent injection of code in other mime types (XSS Attacks)
        add_header X-Content-Type-Options nosniff;
      '';

      virtualHosts."mztski-zhk.cc" =  {
        enableACME = false;
        forceSSL = false;
        locations."/" = {
          proxyPass = "http://127.0.0.1:80";
          proxyWebsockets = false;
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;" +
            # required when the server wants to use HTTP Authentication
            "proxy_pass_header Authorization;"
            ;
        };
      };
    };
  };
}
