{ self, inputs, ... }: {

  flake.nixosModules.hardware = { config, lib, pkgs, modulesPath, ... }: {

    imports =[ 
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "uas" "sd_mod" "sdhci_pci" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/32a2d68f-f6dc-4a9f-9a16-c68435b65eea";
        fsType = "btrfs";
        options = [ "subvol=@" "compress=zstd" "noatime" ];
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/2598-8DBE";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

    fileSystems."/nix" =
      { device = "/dev/disk/by-uuid/32a2d68f-f6dc-4a9f-9a16-c68435b65eea";
        fsType = "btrfs";
        options = [ "subvol=@nix" "compress=zstd" "noatime" ];
        neededForBoot = true;
      };

    fileSystems."/persist" =
      { device = "/dev/disk/by-uuid/32a2d68f-f6dc-4a9f-9a16-c68435b65eea";
        fsType = "btrfs";
        options = [ "subvol=@persist" "compress=zstd" "noatime" ];
        neededForBoot = true;
      };

    fileSystems."/var/log" =
      { device = "/dev/disk/by-uuid/32a2d68f-f6dc-4a9f-9a16-c68435b65eea";
        fsType = "btrfs";
        options = [ "subvol=@log" "compress=zstd" "noatime" ];
        neededForBoot = true;
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/f00cc96b-1844-40d8-85a9-b2f238c9e85b"; }
      ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
    boot.kernelPackages = pkgs.linuxPackages_latest;
  
    # Ensure firmware is available
    hardware.enableAllFirmware = true;
    hardware.cpu.amd.updateMicrocode = true;
  };
}

