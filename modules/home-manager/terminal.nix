{
  config,
  lib,
  pkgs,
  repodir,
  ...
}:

let
  cfg = config.myModules.home-manager.terminal;
in
{
  options.myModules.home-manager.terminal = {
    enable = lib.mkEnableOption "Customized terminal environment";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      awscli = {
        enable = true;
      };

      bat = {
        enable = true;
        config = {
          theme = "kanagawa";
        };
        themes = {
          kanagawa = {
            src = ../../dotfiles/bat/kanagawa.tmTheme;
          };
        };
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
        config = {
          global.hide_env_diff = true;
          global.warn_timeout = 0;
        };
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
        defaultOptions = [
          "--bind=ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"
          "--border=none"
          "--color=dark"
          "--preview='bat --color=always --plain --line-range=:500 {}'"
          "--style=full"
          "--tmux=80%"
        ];
      };

      gh = {
        enable = true;
        extensions = with pkgs; [
          gh-markdown-preview
        ];
      };

      ghostty = {
        enable = true;
        settings = {
          theme = "Kanagawa Wave";
          font-family = "JetBrainsMonoNL Nerd Font";
          title = "\" \"";
          shell-integration-features = "no-cursor";
          cursor-style = "block";
          cursor-style-blink = true;
          mouse-hide-while-typing = true;
          quit-after-last-window-closed = true;
          confirm-close-surface = false;
          window-save-state = "always";
          macos-titlebar-proxy-icon = "hidden";
          macos-option-as-alt = true;
        };
      };

      git = {
        enable = true;
        ignores = [
          "*~"
          "*.swp"
          ".DS_Store"
          ".envrc"
          ".direnv/"
          ".vscode/"
        ];
        settings = {
          user = {
            email = "27653146+dbreyfogle@users.noreply.github.com";
            name = "Danny Breyfogle";
          };
          init.defaultBranch = "main";
          push.autoSetupRemote = "true";
        };
        signing = {
          format = "ssh";
          key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
          signByDefault = true;
        };
      };

      k9s = {
        enable = true;
        settings = {
          k9s = {
            noExitOnCtrlC = true;
            ui.crumbsless = true;
            ui.logoless = true;
            ui.noIcons = true;
            ui.skin = "transparent";
          };
        };
        skins = {
          transparent = ../../dotfiles/k9s/transparent.yaml;
        };
      };

      neovim = {
        enable = true;
        defaultEditor = true;
        extraPackages = with pkgs; [
          gcc
          nodejs
          tree-sitter
        ];
      };

      starship = {
        enable = true;
        enableZshIntegration = true;
      };

      tmux = {
        enable = true;
        sensibleOnTop = false;
        extraConfig = builtins.readFile ../../dotfiles/tmux/tmux.conf;
        plugins = with pkgs.tmuxPlugins; [
          logging
          yank
          {
            plugin = continuum;
            extraConfig = ''
              set -g status-right "" # set early since continuum hooks into status-right
              set -g @continuum-save-interval '5'
            '';
          }
          {
            plugin = resurrect;
            extraConfig = ''
              set -g @resurrect-processes 'false'
            '';
          }
        ];
      };

      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      zsh = {
        enable = true;
        autosuggestion = {
          enable = true;
          strategy = [ "match_prev_cmd" ];
        };
        enableCompletion = true;
        history.ignoreSpace = true;
        initContent = ''
          complete -C $(which aws_completer) aws
        '';
        oh-my-zsh = {
          enable = true;
          plugins = [ "tmux" ];
        };
        sessionVariables = {
          MINIKUBE_IN_STYLE = "false";
          OPENCODE_DISABLE_LSP_DOWNLOAD = "true";
          VALE_CONFIG_PATH = "$HOME/.config/vale/.vale.ini";
          ZSH_TMUX_AUTOSTART = "true";
          ZSH_TMUX_AUTOQUIT = "false";
          ZSH_TMUX_UNICODE = "true";
        };
        envExtra = ''
          [ -f ~/.env ] && source ~/.env
        '';
        shellAliases = {
          ll = "ls -lFhAv --group-directories-first --color";
        };
        syntaxHighlighting.enable = true;
      };
    };

    home.packages = with pkgs; [
      astro-cli
      bash-language-server
      buf
      checkmake
      dbt-fusion
      delve
      docker-language-server
      fastfetch
      fd
      git-filter-repo
      go
      golangci-lint
      gopls
      gotools
      hadolint
      helm-ls
      jq
      kubectl
      kubernetes-helm
      lua-language-server
      markdownlint-cli2
      minikube
      nerd-fonts.jetbrains-mono
      nixd
      nixfmt
      opencode
      prettier
      pyright
      ripgrep
      ruff
      shellcheck
      shfmt
      sqlfluff
      stylua
      taplo
      terraform-ls
      terraform-versions."terraform-1.14"
      tflint
      tldr
      tokei
      uv
      vale
      vim
      vscode-json-languageserver
      yaml-language-server
      yamllint
    ];

    home.file = {
      ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/vim/.vimrc";
    };

    xdg.configFile = {
      "nvim".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/nvim";
      "opencode/opencode.json".source =
        config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/opencode/opencode.json";
      "sqlfluff/.sqlfluff".source =
        config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/sqlfluff/.sqlfluff";
      "starship.toml".source =
        config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/starship/starship.toml";
      "vale/.vale.ini".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/vale/.vale.ini";
      "yamllint/config".source =
        config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/yamllint/config";
    };
  };
}
