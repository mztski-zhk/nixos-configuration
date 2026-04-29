{ self, inputs, ... }: {
  flake.modules.nixos.security.impermanence = {
    programs.fuse.userAllowOther = true;
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/networkmanager/system-connections"
      ];
      files = [
        "/etc/machine-id"
      ];
      users.mztski-zhk = {
        directories = [
          "Applications"
          "Codes"
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".local/share/direnv"
          ".ssh"
          ".config/niri"
        ];
      };
    };
    system.activationScripts.iron-machine-id = ''
      mkdir -p /persist/etc
      touch /persist/etc/machine-id
      ln -snf /persist/etc/machine-id /etc/machine-id
    '';
  };
}