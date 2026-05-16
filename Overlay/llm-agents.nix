{inputs}: final: _prev: {
  llm-agents = inputs.llm-agents.packages.${final.stdenv.hostPlatform.system};
}
