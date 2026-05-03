{ ... }: {
  flake.nixosModules.users = {
    # <-- User Configuration -->
    users.mutableUsers = false;
    users.users.mztski-zhk = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "video"];
      hashedPassword = "$6$5VN3r4VBBPeB7PhY$FpevX.7qOf8M5OKPKNvQ2vRRxy6ny9LFVqdZFxjUwCy.UnU77vRcW8b5bVoqDK.R3YbgYtZbrJDaMnOY4AHZO/";

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPL+DcGvwyp7PYJ88GB5oCZ2sps0XICDMQLZgqWvxMex"
      ];
    };
  };
}
