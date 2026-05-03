{ ... }: {
  flake.homeManagerModules.vscode = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
	yzhang.markdown-all-in-one
	vscode-icons-team.vscode-icons
	usernamehw.errorlens
	timonwong.shellcheck
	stylelint.vscode-stylelint
	rust-lang.rust-analyzer
	redhat.vscode-yaml
	redhat.ansible
	quicktype.quicktype
	prettier.prettier-vscode
	oderwat.indent-rainbow
	ms-vscode.remote-explorer
	ms-vscode.hexeditor
	ms-vscode.cpptools-extension-pack
	ms-vscode-remote.vscode-remote-extensionpack
	ms-vscode-remote.remote-ssh
	ms-vscode-remote.remote-containers
	ms-toolsai.jupyter
	ms-python.python
	ms-python.vscode-pylance
	ms-python.pylint
	ms-python.mypy-type-checker
	ms-python.isort
	ms-python.debugpy
	ms-kubernetes-tools.vscode-kubernetes-tools
	ms-azuretools.vscode-docker
	ms-azuretools.vscode-containers
	mechatroner.rainbow-csv
	leonardssh.vscord
	kamikillerto.vscode-colorize
	kamadorueda.alejandra
	ibm.output-colorizer
	github.vscode-pull-request-github
	github.vscode-github-actions
	github.github-vscode-theme
	github.copilot-chat
	github.copilot
	github.codespaces
	detachhead.basedpyright
	bierner.markdown-preview-github-styles
	bierner.markdown-mermaid
	bierner.github-markdown-preview
	bierner.docs-view
      ];
    };
  };
}
