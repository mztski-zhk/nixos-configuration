{ inputs, self, ... }: {

  # <-- nixos home-manager configuration -->
  # only import in flake.nixosModules,
  # no need to specify and build the standalone home-manager
  # using nixos home-manager
  flake.nixosModules.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
      extraSpecialArgs = {inherit inputs;};
      users.mztski-zhk = inputs.self.homeModules.homeProfileNixos;
    };
  };

  # <-- archlinux home-manager configuration -->
  flake.homeConfigurations = {
    mztski-zhk-arch = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

      # import arch profile
      modules = [
        inputs.self.homeModules.homeProfileArch
        {
          home.username = "mztski-zhk";
          home.homeDirectory = "/home/mztski-zhk";
          home.stateVersion = "26.05";
          programs.home-manager.enable = true;
        }
      ];

      extraSpecialArgs = {inherit inputs self;};
    };

    # <-- raspberry pi home-manager configuration -->
    mztski-zhk-pi = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.aarch64-linux;

      # import pi profile
      modules = [
        inputs.self.homeModules.homeProfilePi
        {
          home.username = "mztski-zhk";
          home.homeDirectory = "/home/mztski-zhk";
          home.stateVersion = "26.05";
          programs.home-manager.enable = true;
        }
      ];
      extraSpecialArgs = {inherit inputs self;};
    };
  };
}
