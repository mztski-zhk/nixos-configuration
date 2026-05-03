{ inputs, ... }: {
  flake.nixosModules.impermanence = {

    imports = [ 
      inputs.impermanence.nixosModules.impermanence
    ];


    # <-- Impermanence -->
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

    # <-- Force machine-id to persist correctly -->
    system.activationScripts.iron-machine-id = ''
      mkdir -p /persist/etc
      touch /persist/etc/machine-id
      ln -snf /persist/etc/machine-id /etc/machine-id
    '';
  };
}
