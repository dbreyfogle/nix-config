{
  config,
  pkgs,
  repodir,
  ...
}:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        general.import = [ "~/.config/alacritty/themes/onehalfdark.toml" ];
        cursor = {
          blink_timeout = 0;
          style.blinking = "Always";
        };
        env.TERM = "xterm-256color";
        font.normal = {
          family = "FiraCode Nerd Font";
          style = "Retina";
        };
        window = {
          decorations = "none";
          dynamic_padding = true;
        };
      };
    };

    awscli = {
      enable = true;
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
    };

    git = {
      enable = true;
      ignores = [
        "*~"
        "*.swp"
        ".DS_Store"
        ".aider*"
        ".direnv/"
        "Session.vim"
      ];
      userEmail = "27653146+dbreyfogle@users.noreply.github.com";
      userName = "Danny Breyfogle";
      signing = {
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = "true";
      };
    };

    gh = {
      enable = true;
    };

    k9s = {
      enable = true;
      settings = {
        k9s = {
          noExitOnCtrlC = true;
          ui.logoless = true;
          ui.noIcons = true;
        };
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        ansible-language-server
        ansible-lint
        bash-language-server
        buf
        checkmake
        delve
        dockerfile-language-server-nodejs
        fd
        gcc
        golangci-lint
        gopls
        hadolint
        helm-ls
        lua-language-server
        markdownlint-cli2
        nixd
        nixfmt-rfc-style
        nodejs
        nodePackages.prettier
        pyright
        ripgrep
        rubocop
        rubyPackages.solargraph
        ruff
        shellcheck
        shfmt
        stylua
        taplo
        terraform-ls
        tflint
        vale
        vscode-langservers-extracted
        yaml-language-server
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
            # Theme (must be set before tmux-continuum due to a bug)
            set -g status-left "#[fg=green,bold][#S] "
            set -g status-left-length 50
            set -g status-right ""
            set -g status-style fg=gray60,bg=default
            setw -g window-status-current-style fg=green,bold

            # Faster save interval
            set -g @continuum-save-interval '5'
          '';
        }
        {
          plugin = resurrect;
          extraConfig = ''
            # Fix parsing issue with nix paths
            set -g @resurrect-hook-post-save-all 'sed -i "/^pane\t.*\tnvim\t/ s#\(\tnvim\t\).*#\1:nvim#" ${config.home.homeDirectory}/.tmux/resurrect/last'
          '';
        }
      ];
    };

    zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
        strategy = [ "match_prev_cmd" ];
      };
      enableCompletion = true;
      history.ignoreSpace = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "argocd"
          "aws"
          "docker"
          "docker-compose"
          "git"
          "helm"
          "kubectl"
          "terraform"
          "tmux"
          "z"
        ];
      };
      shellAliases = {
        l = "ls -lFhAv --group-directories-first --color";
      };
      syntaxHighlighting.enable = true;
    };
  };

  home.packages = with pkgs; [
    aider-chat-full
    argocd
    asciinema
    asciinema-agg
    git-filter-repo
    kubectl
    kubernetes-helm
    nerd-fonts.fira-code
    nixd
    nixfmt-rfc-style
    terraform-versions."1.11"
    tldr
    vim
  ];

  home.sessionVariables = {
    MINIKUBE_IN_STYLE = "false";
    VALE_CONFIG_PATH = "$HOME/.config/vale/.vale.ini";
    ZSH_TMUX_AUTOSTART = "true";
    ZSH_TMUX_AUTOQUIT = "false";
    ZSH_TMUX_UNICODE = "true";
  };

  home.file = {
    ".aider.conf.yml".source =
      config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/aider/.aider.conf.yml";
    ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/vim/.vimrc";
  };

  xdg.configFile = {
    "alacritty/themes".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/alacritty";
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/nvim";
    "starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/starship/starship.toml";
    "vale/.vale.ini".source = config.lib.file.mkOutOfStoreSymlink "${repodir}/dotfiles/vale/.vale.ini";
  };
}
