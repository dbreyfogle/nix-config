{
  config,
  lib,
  pkgs,
  inputs,
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
      awscli.enable = true;

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

      btop = {
        enable = true;
        settings = {
          color_theme = "kanagawa-wave";
          theme_background = false;
        };
        themes = {
          kanagawa-wave = builtins.readFile ../../dotfiles/btop/kanagawa-wave.theme;
        };
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
        config = {
          global.hide_env_diff = true;
          global.warn_timeout = 0;
        };
        nix-direnv.enable = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
        defaultOptions = [
          "--bind=ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"
          "--border=none"
          "--layout=reverse"
          "--preview='bat --color=always --plain --line-range=:500 {}'"
          "--style=full"
          "--popup=80%"
        ];
      };

      gh = {
        enable = true;
        extensions = with pkgs; [ gh-markdown-preview ];
      };

      ghostty = {
        enable = true;
        package = pkgs.unstable.ghostty;
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
        package = pkgs.unstable.neovim-unwrapped;
        defaultEditor = true;
        sideloadInitLua = true;
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
        package = pkgs.unstable.tmux;
        sensibleOnTop = false;
        plugins = with pkgs.tmuxPlugins; [
          {
            plugin = resurrect;
            extraConfig = ''
              set -g @resurrect-processes 'false'
            '';
          }
          {
            plugin = continuum; # must load after resurrect
            extraConfig = ''
              set -g @continuum-save-interval '1'
              set -g @continuum-restore 'on'
            '';
          }
          yank
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
        defaultKeymap = "emacs";
        enableCompletion = true;
        envExtra = ''
          [ -f ~/.env ] && source ~/.env
        '';
        history.ignoreSpace = true;
        shellAliases = {
          ll = "ls -lFhAv --group-directories-first --color";
        };
        syntaxHighlighting.enable = true;
      };
    };

    home.packages =
      (with pkgs; [
        astro-cli
        bash-language-server
        buf
        checkmake
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
        opentofu
        postgresql
        prettier
        pyright
        ripgrep
        ruff
        shellcheck
        shfmt
        sqlfluff
        stylua
        taplo
        tldr
        tofu-ls
        tokei
        uv
        vale
        vim
        vscode-json-languageserver
        yaml-language-server
        yamllint
        zk
      ])
      ++ (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
        pi
      ]);

    xdg.configFile = {
      "nvim".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/nvim";
      "sqlfluff/.sqlfluff".source =
        config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/sqlfluff/.sqlfluff";
      "starship.toml".source =
        config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/starship/starship.toml";
      "tmux/tmux.conf".text = lib.mkOrder 750 (builtins.readFile ../../dotfiles/tmux/tmux.conf);
      "vale/.vale.ini".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/vale/.vale.ini";
      "vim/vimrc".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/vim/vimrc";
      "yamllint/config".source =
        config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/yamllint/config";
      "zk/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/zk/config.toml";
      "zk/templates".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/zk/templates";
    };
  };
}
