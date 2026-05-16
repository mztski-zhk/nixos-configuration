{self, ...}: {
  flake.nixosModules.security = {
    imports = with self.nixosModules; [
      camera
      apparmor
      fail2ban
      firewall
      password
      sudo
    ];
  };
}
