{ ... }: {
  flake.homeManagerModules.zed-editor = { pkgs, lib, ... }: {
    programs.zed-editor = {
      enable = true;
      extensions = [ "nix" "toml" "rust" ];
      userSettings = {
	theme = {
	  mode = "system";
	  # dark = "One Dark";
	  # light = "One Light";
	};

	language_models = {
	  enabled = true;
	  openai = {
	    api_url = "http://100.100.10.1:4000/v1";
	    available_models = [
	      {
		name = "nvidia/glm4.7";
		display_name = "nvidia/glm4.7";
		max_tokens = 2000000;
	      }
	    ];
	  };
	};
	assistant = {
	  default_model = {
	    provider = "openai";
	    model = "gpt-4o";
	};

	node = {
	  path = lib.getExe pkgs.nodejs;
	  npm_path = lib.getExe' pkgs.nodejs "npm";
	};
	terminal = {
	  alternate_scroll = "off";
	  blinking = "off";
	  copy_on_select = true;
	  dock = "bottom";
	  detect_venv = {
	    on = {
	      directories = [ ".env" ".venv" ];
	      activate_script = "default";
	    };
	  };
	  env = {
	    TERM = "alacritty";
	  };
	  font_family = "Jetbrains Mono Nerd Font";
	  font_features = null;
	  font_size = null;
	  line_height = "comfortable";
	  option_as_meta = false;
	  button = false;
	  shell = "system";
	  toolbar = {
	    title = true;
	  };
	  working_directory = "current_project_directory";
	};

	load_direnv = "shell_hook";
	hour_format = "hour24";
	vim_mode = true;

	extensions = [ "nix" "html" "toml" "dockerfile" "catppuccin" "catppuccin-blur" "color-highlight" "ruff" ];
	};
      };
    };
  };
}
