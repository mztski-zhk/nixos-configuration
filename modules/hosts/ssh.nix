{ ... }: {
  flake.nixosModules.ssh = {
    # <-- ssh and mosh -->
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    programs.mosh.enable = true;
    services.openssh = {
      enable = true;
      ports = [ 14690 ];
      settings = {
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = true;
        PermitRootLogin = "no";
        AllowUsers = [ "mztski-zhk" ];
      };
    };
  };
}
