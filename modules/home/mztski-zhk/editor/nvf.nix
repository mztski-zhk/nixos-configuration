{
  lib,
  inputs,
  ...
}: {
  flake.homeModules.nvf = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      inputs.nvf.homeManagerModules.default
    ];

    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = false;
        vimAlias = false;
        lineNumberMode = "relative";

        opts = {
          # tab behavier
          shiftwidth = 2;
          tabstop = 2;
          expandtab = true;

          signcolumn = "yes";

          scrolloff = 8;

          undofile = true;
          undodir = "${config.home.homeDirectory}/.local/state/nvim/undo";
          visualbell = true;

          foldlevel = 99;
          foldlevelstart = 99;
          foldenable = true;
        };

        startPlugins = let
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        in [
          pkgs.vimPlugins.catppuccin-nvim
        ];

        luaConfigPost = ''
          require("catppuccin").setup({
            flavour = "macchiato",
            transparent_background = true,
            integrations = {
              alpha = true,
              blink_cmp = true,
              mini = { enabled = true, indentscope_color = "" },
              which_key = true,
              fzf = true,
              notify = true,
            },
          })
          vim.cmd.colorscheme("catppuccin")

          vim.api.nvim_create_autocmd("BufReadPost", {
            pattern = "*",
            callback = function()
              local line = vim.fn.line("'\"")
              if line > 1 and line <= vim.fn.line("$") then
                vim.cmd("normal! g'\"")
              end
            end,
          })
        '';

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lightbulb = {
            enable = true;
            autocmd.enable = true;
          };
          lspconfig.enable = true;
          lspkind.enable = true;
          nvim-docs-view.enable = true;
          otter-nvim.enable = true;
        };

        languages = {
          bash.enable = true;
          markdown.enable = true;

          python = {
            enable = true;
            lsp.servers = ["ruff"];
          };
          rust.enable = true;
          nix = {
            enable = true;
            format.enable = true;
            lsp.servers = ["nil"];
          };

          html.enable = true;
          # javascript.enable = true;
          typescript.enable = true;
          css.enable = true;

          sql.enable = true;

          json.enable = true;
          toml.enable = true;
          yaml.enable = true;
        };

        # <-- Plugin setup -->
        # for code completion
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          mappings = {
            confirm = "<C-CR>";
          };
          setupOpts.keymap = {
            preset = "none";
            "<Down>" = ["select_next" "fallback"];
            "<Up>" = ["select_prev" "fallback"];
            "<C-j>" = ["select_next" "fallback"];
            "<C-k>" = ["select_prev" "fallback"];
          };
          sourcePlugins = {
            ripgrep.enable = true;
            spell.enable = true;
          };
          setupOpts.signature.enabled = true;
        };
        autocomplete.enableSharedCmpSources = true;

        # for search/hint key maps
        binds.whichKey.enable = true;

        # for sync vim clipboard with system clipboard
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
        };

        # for dashboard
        dashboard.alpha = {
          enable = true;
          theme = null;
          layout = let
            mkBtn = shortcut: label: command: {
              type = "button";
              val = label;
              on_press = lib.generators.mkLuaInline ''
                function()
                  vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("${command}", true, false, true),
                    "t", false
                  )
                end
              '';
              opts = {
                position = "center";
                shortcut = shortcut;
                cursor = 3;
                width = 48;
                align_shortcut = "right";
                hl_shortcut = "Keyword";
              };
            };
            sectionLabel = text: {
              type = "text";
              val = "── ${text} ──";
              opts = {
                position = "center";
                hl = "Title";
              };
            };
            catSpace = {
              type = "padding";
              val = 1;
            };
          in [
            {
              type = "padding";
              val = 1;
            }
            {
              type = "text";
              val = [
                "                                 "
                "        ╱l、                     "
                "      （ﾟ､ ｡ ７                   "
                "        l  ~ ヽ                   "
                "        じしf_,)ノ                "
                "                                 "
              ];
              opts = {
                position = "center";
                hl = "Type";
              };
            }
            {
              type = "padding";
              val = 2;
            }
            {
              type = "group";
              val = [
                (sectionLabel "File")
                (mkBtn "e" "  New file" "<cmd>ene<CR>")
                (mkBtn "SPC f f" "󰈞  Find file" "<cmd>FzfLua files<CR>")
                (mkBtn "SPC f g" "󰈬  Live grep" "<cmd>FzfLua live_grep<CR>")
                (mkBtn "SPC f o" "  Recent" "<cmd>FzfLua oldfiles<CR>")
                (mkBtn "SPC f w" "󰱚  Find word" "<cmd>FzfLua grep_cword<CR>")
                catSpace
                (sectionLabel "Project")
                (mkBtn "SPC p f" "󰙅  File browser" "<<cmd>lua MiniFiles.open()<CR>")
                (mkBtn "SPC p b" "󰓩  Buffers" "<cmd>FzfLua buffers<CR>")
                (mkBtn "SPC p k" "  Keymaps" "<cmd>FzfLua keymaps<CR>")
                catSpace
                (sectionLabel "Git")
                (mkBtn "SPC g s" "󰊢  Git status" "<cmd>FzfLua git_status<CR>")
                (mkBtn "SPC g c" "󰜘  Git commits" "<cmd>FzfLua git_commits<CR>")
                (mkBtn "SPC g b" "󰘬  Branches" "<cmd>FzfLua git_branches<CR>")
                catSpace
                (sectionLabel "Notes")
                (mkBtn "SPC n f" "  Find notes" "<cmd>ObsidianQuickSwitch<CR>")
                (mkBtn "SPC n t" "󰃭  Today" "<cmd>ObsidianToday<CR>")
                (mkBtn "SPC n d" "󰥔  Dailies" "<cmd>ObsidianDailies<CR>")
                catSpace
                (sectionLabel "System")
                (mkBtn "SPC s l" "󱒋  Last session" "<cmd>lua require('mini.sessions').select('read')<CR>")
                (mkBtn "SPC s s" "󰆓  Save session" "<cmd>lua require('mini.sessions').select('write')<CR>")
                (mkBtn "SPC u p" "󰚰  UEdit config" "<cmd>edit< /etc/nixos<CR>")
                (mkBtn "q" "󰅚  Quit" "<cmd>qa<CR>")
              ];
              opts = {
                spacing = 0;
              };
            }
            {
              type = "padding";
              val = 1;
            }
            {
              type = "text";
              val = lib.generators.mkLuaInline ''
                function()
                  local ok, lz = pcall(require, "lz.n")
                  if ok and lz.stats then
                    local stats = lz.stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return "⚡ loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
                  end
                  local v = vim.version()
                  return "neovim " .. v.major .. "." .. v.minor .. "." .. v.patch .. "  •  mztski-zhk"
                end
              '';
              opts = {
                position = "center";
                hl = "Comment";
              };
            }
          ];
          opts = {
            margin = 5;
          };
        };

        # -- disabled, since maybe not usful
        # diagnostics.nvim-lint.enable = true;

        # for fast startup | might break things
        enableLuaLoader = true;

        # for formatter
        formatter.conform-nvim.enable = true;

        # for fuzzy finding file
        fzf-lua = {
          enable = true;
          profile = "default";
        };

        # for dynamic plugins loading, increse performence
        lazy.enable = true;

        # mini stack
        # for buffer management
        mini.ai.enable = true;
        # for animate
        # -- disabled, since cause motions incredibly slow
        # mini.animate.enable = true;
        # for better preset
        mini.basics.enable = true;
        # for better select buffer
        mini.bracketed.enable = true;
        # for preserve ui
        mini.bufremove.enable = true;
        # for which key instant hint
        mini.clue.enable = true;
        # for better color scheme
        mini.colors.enable = true;
        # for faster comment
        mini.comment.enable = true;
        # for highlight same words
        mini.cursorword.enable = true;
        # for git tracking
        mini.diff.enable = true;
        # for current plugin improvement
        mini.extra.enable = true;
        # for file browse
        mini.files.enable = true;
        # for git managing
        mini.git.enable = true;
        # for labeling color
        mini.hipatterns.enable = true;
        # for icon provider
        mini.icons.enable = true;
        # for indent displayer
        mini.indentscope.enable = true;
        # for faster pattern jump
        mini.jump.enable = true;
        # Same, but in while file
        mini.jump2d.enable = true;
        # error displaying
        mini.map.enable = true;
        # qol
        mini.misc.enable = true;
        # preserve curser indent
        mini.move.enable = true;
        # notify error
        mini.notify.enable = true;
        # qol operator
        mini.operators.enable = true;
        # brankets pairing
        mini.pairs.enable = true;
        # session manage
        mini.sessions.enable = true;
        # snippets
        mini.snippets.enable = true;
        # qol switch multiline
        mini.splitjoin.enable = true;
        # dashboard
        # -- disabled since it does not support ascii art
        # mini.starter.enable = true;
        # status line
        mini.statusline.enable = true;
        # surround edit
        mini.surround.enable = true;
        # top bar
        mini.tabline.enable = true;
        # remove whitespace
        mini.trailspace.enable = true;
        # recent files/bookmark
        mini.visits.enable = true;

        # for note taking/markdown editing
        notes.obsidian.enable = true;

        # code runner
        runner.run-nvim.enable = true;

        # code snippeta
        # snippets.luasnip.enable = true;

        # spell check
        spellcheck = {
          enable = true;
          languages = ["en"];
          # programmingWordlist.enable = true;
        };

        # syntax highlight
        syntaxHighlighting = true;

        # file search
        # telescope.enable = true;
        # telescope.extensions = {
        #   fzf-native.enable = true;
        #   ui-select.enable = true;
        #   file-browser.enable = true;
        # };

        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };

        # syntax lighlighting
        treesitter = {
          enable = true;
          autotagHtml = true;
          context = {
            enable = true;
            setupOpts = {
              max_lines = 4;
              trim_scope = "outer";
            };
          };
          fold = false;
          grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
            regex
            python
            nix
            rust
            lua
            typescript
            html
            css
          ];
        };

        # ui borders
        ui.borders = {
          enable = true;
          globalStyle = "rounded";
          plugins.which-key.enable = true;
        };

        ui.nvim-highlight-colors.enable = true;

        ui.nvim-ufo.enable = true;

        ui.smartcolumn.enable = true;

        utility.ccc = {
          enable = true;
          setupOpts.alpha_show = "auto";
        };

        utility.direnv.enable = true;

        #utility.images.image-nvim = {
        #enable = true;
        #setupOpts.backend = "kitty";
        #};

        #utility.images.img-clip.enable = true;

        utility.mkdir.enable = true;

        utility.preview.markdownPreview = {
          enable = true;
          lazyRefresh = true;
        };

        visuals.nvim-web-devicons.enable = true;

        visuals.tiny-devicons-auto-colors.enable = true;

        visuals.fidget-nvim.enable = true;

        visuals.highlight-undo.enable = true;

        utility.undotree.enable = true;

        keymaps = [
        ];
      };
    };
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
