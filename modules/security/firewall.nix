{ self, inputs, ... }: {
  flake.modules.nixos.security.firewall = {
    networking.firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
    security.apparmor = {
      enable = true;
      enableCache = true;
      killUnconfinedConfinables = true;
    };
    services.fail2ban = {
      enable = true;
      maxretry = 5;
      ignoreIP = [
        "127.0.0.1/8" "172.16.0.0/12" "192.168.0.0/16" "100.64.0.0/10"
        "8.8.8.8" "1.1.1.1"
        "wiki.nixos.org"
      ];
      bantime = "24h";
      bantime-increment = {
        enable = true;
        formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
        maxtime = "168h";
        overalljails = true;
      };
      jails = {
        nginx-http-auth = ''
enabled = true
port = http,https
logpath = /var/log/nginx/*.log
backend = polling
journalmatch =
        '';
        nginx-botsearch = ''
enabled = true
port = http,https
logpath = /var/log/nginx/*.log
backend = polling
journalmatch =
        '';
        nginx-bad-request = ''
enabled = true
port = http,https
logpath = /var/log/nginx/*.log
backend = polling
journalmatch =
        '';
      };
    };
  };
}