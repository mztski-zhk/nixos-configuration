{ self, ... }: {
  flake.nixosModules.security = {
    imports = with self.nixosModules; [
      apparmor
      fail2ban
      firewall
      password
      sudo
    ];
  };
}
