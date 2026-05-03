{ inputs, ... }: {
  flake.nixosModules.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
      extraSpecialArgs = {inherit inputs;};
      # Point to your modularized user home.nix
      users.mztski-zhk = {
        imports = [
          ../../users/mztski-zhk/home.nix
        ];
      };
    };
  };
}
