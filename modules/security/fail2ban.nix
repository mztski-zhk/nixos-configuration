{ ... }: {
  flake.nixosModules.fail2ban = {
    services.fail2ban = {
      enable = true;
      # Ban IP after 5 failures
      maxretry = 5;
      ignoreIP = [
        # Allow list for some subnets
        "127.0.0.1/8" "172.16.0.0/12" "192.168.0.0/16" "100.64.0.0/10"
        "8.8.8.8" "1.1.1.1" # allow a specific IP
        "wiki.nixos.org" # resolve the IP via DNS
      ];
      bantime = "24h"; # Ban IPs for one day on the first ban
      bantime-increment = {
        enable = true; # Enable increment of bantime after each violation
        formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
        # multipliers = "1 2 4 8 16 32 64";
        maxtime = "168h"; # Do not ban for more than 1 week
        overalljails = true; # Calculate the bantime based on all the violations
      };
      jails = {
        nginx-http-auth = ''
          enabled  = true
          port     = http,https
          logpath  = /var/log/nginx/*.log
          backend  = polling
          journalmatch =
        '';
        nginx-botsearch = ''
          enabled  = true
          port     = http,https
          logpath  = /var/log/nginx/*.log
          backend  = polling
          journalmatch =
        '';
        nginx-bad-request = ''
          enabled  = true
          port     = http,https
          logpath  = /var/log/nginx/*.log
          backend  = polling
          journalmatch =
        '';
      };
    };
  };
}
