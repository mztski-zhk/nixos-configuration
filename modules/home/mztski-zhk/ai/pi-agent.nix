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
    home.file.".pi/agent/models.json".text = ''
      {
        "providers": {
          "llama-cpp": {
            "baseUrl": "http://127.0.0.1:11434",
            "api": "openai-completions",
            "apiKey": "1",
            "models": [
              {
                "id": "Qwopus3.5-9B-coder-Exp-Q4_K_M",
                "name": "Qwopus3.5-9B-coder-Exp-Q4_K_M"
              }
            ]
          },

          "openrouter": {
            "baseUrl": "https://openrouter.ai/api/v1",
            "api": "openai-completions",
            "apiKey": "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",
            "models": [
              {
                "id": "deepseek/deepseek-v4-flash:free",
                "name": "deepseek/deepseek-v4-flash:free"
              },
              {
                "id": "google/gemma-4-31b-it:free",
                "name": "google/gemma-4-31b-it:free"
              },
              {
                "id": "google/gemma-4-26b-a4b-it:free",
                "name": "google/gemma-4-26b-a4b-it:free"
              },
              {
                "id": "minimax/minimax-m2.5:free",
                "name": "minimax/minimax-m2.5:free"
              }
            ]
          },
          "nvidia_nim": {
            "baseUrl": "https://integrate.api.nvidia.com/v1",
            "api": "openai-completions",
            "apiKey": "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",
            "models": [
              {
                "id": "minimaxai/minimax-m2.7",
                "name": "nvidia/minimax-m2.7"
              },
            ]
          }
        }
      }
    '';
  };
}
