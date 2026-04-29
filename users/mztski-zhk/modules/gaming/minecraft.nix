{
  flake.modules = {
    homeManager.gaming = { pkgs, ... }: {
      home.packages = with pkgs; [
        (prismlauncher.override {
          jdks = [
            zulu17
            zulu
          ];
        })
        (llama-cpp.override { cudaSupport = true; })
      ];
    };
  };
}