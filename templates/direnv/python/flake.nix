{
  description = "Some Project Example";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    nixpkgs-python = {
      url = "github:cachix/nixpkgs-python";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = { self, nixpkgs, devenv, flake-utils, ... } @ inputs: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            ({ pkgs, config, ... }: {
              packages = with pkgs; [
                gcc
                stdenv.cc.cc.lib
                zlib
                cudaPackages.cudatoolkit
                uv
              ];

              languages.python = {
                enable = true;
                version = "3.12";

                venv = {
                  enable = true;
                };
                uv = {
                  enable = true;
                  sync.enable = true;
                };
              };

              env = {
                CUDA_HOME = "${pkgs.cudaPackages.cudatoolkit}";
              };

              enterShell = ''
                echo "Init project $PWD."
                export LD_LIBRARY_PATH="/run/opengl-driver/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:$LD_LIBRARY_PATH"
                export PATH="$CUDA_HOME/bin:$PATH"
                export PIP_PRE=1

                uv sync

                echo "Project init."
              '';
            })
          ];
        };
      }
    );
}

