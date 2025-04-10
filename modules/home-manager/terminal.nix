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
        ".direnv/"
        "Session.vim"
      ];
      userEmail = "27653146+dbreyfogle@users.noreply.github.com";
      userName = "Danny Breyfogle";
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
      extraConfig = ''
        # [[ Keymaps ]]

        # Pane navigation
        bind j select-pane -D
        bind k select-pane -U
        bind h select-pane -L
        bind l select-pane -R

        # Use current path for new splits
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        # Prompt navigation (OSC 133)
        bind K copy-mode\; send-keys -X previous-prompt
        bind J copy-mode\; send-keys -X next-prompt

        # Convenience shortcuts
        bind -r "<" swap-window -d -t -1
        bind -r ">" swap-window -d -t +1
        bind A setw synchronize-panes\; display-message "synchronize-panes: #{?pane_synchronized,on,off}"
        bind S command-prompt -p "join-pane source:"  "join-pane -s :'%%'"
        bind T command-prompt -p "join-pane target:"  "join-pane -t :'%%'"

        # [[ Options ]]

        # Window renaming
        set -g allow-rename off
        set -g renumber-windows on

        # Display pane numbers until selected
        bind -T prefix q display-panes -d 0

        # Increase history limit
        set -g history-limit 10000

        # Vim compatibility
        set -gs escape-time 10
        set -g focus-events on

        # Vim-style copy
        setw -g mode-keys vi
        bind -T copy-mode-vi v send -X begin-selection

        # Enable mouse usage
        set -g mouse on

        # Terminal colors
        set -g default-terminal "tmux-256color"
        set -ga terminal-overrides ",*256col*:Tc"
      '';
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = continuum;
          extraConfig = ''
            # Theme (must be set before tmux-continuum due to a bug)
            set -g status-left ""
            set -g status-right "#{?client_prefix,#[fg=green bold],#[fg=default]}[#S]#[fg=default nobold]  #(date '+%a %b %-d  %-I:%M %p')"
            set -g status-style bg=default,fg=white
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
        logging
        yank
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
    argocd
    asciinema
    asciinema-agg
    git-filter-repo
    kubectl
    kubernetes-helm
    nerd-fonts.fira-code
    tldr
    vim
  ];

  home.sessionVariables = {
    MINIKUBE_IN_STYLE = "false";
    VALE_CONFIG_PATH = "$HOME/.config/vale/.vale.ini";
    VIRTUAL_ENV_DISABLE_PROMPT = 1;
    ZSH_TMUX_AUTOSTART = "true";
    ZSH_TMUX_AUTOQUIT = "false";
    ZSH_TMUX_UNICODE = "true";
  };

  home.file = {
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
