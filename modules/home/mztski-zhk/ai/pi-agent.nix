{...}: {
  flake.homeModules.pi-agent = {
    pkgs,
    config,
    ...
  }: {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "pi-agent";
        buildInputs = [pkgs.makeWrapper];
        paths = [pkgs.llm-agents.pi];
        postBuild = ''
          wrapProgram $out/bin/pi \
            --set NPM_CONFIG_PREFIX ${config.home.homeDirectory}/.pi/npm/ \
            --prefix PATH : ${
            pkgs.lib.makeBinPath [
              pkgs.nodejs_latest
            ]
          }
        '';
      })
    ];
    home.sessionVariables = {
      PI_CODING_AGENT_DIR = "./pi-config/";
    };
    home.file."pi-config/models.json".text = ''
      {
        "providers": {
          "llama-cpp": {
            "baseUrl": "http://127.0.0.1:11434",
            "api": "openai-completions",
            "apiKey": "1",
            "models": [
              {
              "id": "",
              "name": ""
              }
            ]
          }
        }
      }
    '';
  };
}
