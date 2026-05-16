{...}: {
  flake.nixosModules.camera = {pkgs, ...}: {
    # just to make sure that my camera will not
    # automatically opened, enforce in kernel.
    boot.blacklistedKernelModules = ["uvcvideo"];

    environment.systemPackages = with pkgs; [
      psmisc
      lsof
    ];

    programs.zsh.shellAliases = {
      open-camera = "sudo modprobe uvcvideo";
      close-camera = /etc/nixos/modules/security/camera.sh;
    };
  };
}
