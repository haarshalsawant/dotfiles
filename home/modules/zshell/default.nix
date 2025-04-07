{ config
, lib
, ...
}: {

  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      autocd = true;

      history = {
        extended = true;
        ignoreAllDups = true;
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        save = 15000;
        size = 15000;
        path = "$HOME/.local/share/zsh/history";
        share = true;
      };

      shellAliases = {
        # Navigation
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        # Modern ls replacements
        l = "eza -l --icons --group-directories-first";
        ls = "eza --icons --group-directories-first";
        ll = "eza -l --icons --group-directories-first --git";
        la = "eza -a --icons --group-directories-first";
        lt = "eza --tree --icons --level=2";
        # Git shortcuts
        g = "git";
        ga = "git add";
        gs = "git status";
        gc = "git commit";
        gph = "git push";
        gpl = "git pull";
        # Safety nets
        rm = "rm -I";
        cp = "cp -i";
        mv = "mv -i";
        # Modern alternatives
        cat = "bat";
        grep = "rg";
        find = "fd";
        # Handy shortcuts
        ff = "fastfetch";
        cl = "clear";
        x = "exit";
        v = "nvim";
        # Additional useful aliases
        ports = "netstat -tulpn";
        path = "echo $PATH | tr ':' '\n'";
        weather = "curl wttr.in";
        ip = "ip --color=auto";
        diff = "diff --color=auto";
        ping = "ping -c 5";
        mkdir = "mkdir -pv";
        wget = "wget -c";
      };

      # Environment setup
      envExtra = ''
        export MANPAGER="nvim +Man!"
        export PATH="$HOME/.local/bin:$PATH"
        export EDITOR="nvim"
        export VISUAL="nvim"
        export TERM="xterm-256color"
        export LANG="en_US.UTF-8"
        export LC_ALL="en_US.UTF-8"
      '';

      # Functional config
      initExtra = ''
        # Improved completion
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "$LS_COLORS"
        zstyle ':completion:*' special-dirs true
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$HOME/.cache/zsh/.zcompcache"

        # Improved Vi mode
        bindkey -v
        bindkey '^?' backward-delete-char
        bindkey '^h' backward-delete-char
        bindkey '^w' backward-kill-word
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey '^[[C' forward-char
        bindkey '^[[D' backward-char

        # Directory stack
        setopt AUTO_PUSHD
        setopt PUSHD_IGNORE_DUPS
        setopt PUSHD_SILENT
        setopt EXTENDED_GLOB
        setopt NO_BEEP
        setopt AUTO_CD
        setopt MULTIOS
        setopt CORRECT
        setopt CORRECT_ALL
        setopt DVORAK
        setopt NO_HUP
        setopt IGNORE_EOF
        setopt PRINT_EIGHT_BIT
        setopt RC_QUOTES
        setopt RM_STAR_SILENT
        setopt SHORT_LOOPS
        setopt NO_FLOW_CONTROL

        # Load FZF
        if [ -n "$(command -v fzf-share)" ]; then
          source "$(fzf-share)/key-bindings.zsh"
          source "$(fzf-share)/completion.zsh"
        fi

        # Custom functions
        function mkcd() {
          mkdir -p "$1" && cd "$1"
        }

        function extract() {
          if [ -f "$1" ] ; then
            case "$1" in
              *.tar.bz2)   tar xjf "$1"     ;;
              *.tar.gz)    tar xzf "$1"     ;;
              *.bz2)       bunzip2 "$1"     ;;
              *.rar)       unrar x "$1"     ;;
              *.gz)        gunzip "$1"      ;;
              *.tar)       tar xf "$1"      ;;
              *.tbz2)      tar xjf "$1"     ;;
              *.tgz)       tar xzf "$1"     ;;
              *.zip)       unzip "$1"       ;;
              *.Z)         uncompress "$1"  ;;
              *.7z)        7z x "$1"        ;;
              *)          echo "'$1' cannot be extracted via extract()" ;;
            esac
          else
            echo "'$1' is not a valid file"
          fi
        }
      '';
    };

    fzf = {
      enable = true;
      defaultOptions = [
        "--color=dark"
        "--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe"
        "--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef"
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    bat = {
      enable = true;
      config.theme = "OneHalfDark";
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--pretty"
      ];
    };

    eza = {
      enable = true;
      extraOptions = [
        "--classify"
        "--color-scale"
        "--git"
        "--group-directories-first"
      ];
    };

    # Starship prompt
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        
        format = "$all";

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
          vicmd_symbol = "[❮](bold green)";
        };

        directory = {
          style = "bold blue";
          read_only = " ";
          truncation_length = 3;
          truncation_symbol = "…/";
        };

        git_branch = {
          format = "[$symbol$branch]($style) ";
          style = "bold purple";
          symbol = " ";
        };

        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold red";
          conflicted = "=";
          ahead = "⇡$count";
          behind = "⇣$count";
          diverged = "⇕⇡$ahead_count⇣$behind_count";
          untracked = "?";
          stashed = "≡";
          modified = "!";
          staged = "+";
          renamed = "»";
          deleted = "✘";
        };

        git_state = {
          format = "([$state( $progress_current/$progress_total)]($style)) ";
          style = "bright-black";
        };

        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
          min_time = 2000;
        };

        nix_shell = {
          format = "[$symbol$state]($style) ";
          symbol = "❄️ ";
          style = "bold blue";
        };

        memory_usage = {
          format = "$symbol[$ram_pct]($style) ";
          symbol = "󰍛 ";
          style = "bold dimmed white";
          threshold = 75;
        };

        status = {
          format = "[$symbol$status]($style) ";
          symbol = "✖";
          success_symbol = "✓";
          not_executable_symbol = "🚫";
          not_found_symbol = "🔍";
          sigint_symbol = "⚡";
          signal_symbol = "⚡";
          style = "bold red";
          map_symbol = true;
          disabled = false;
        };

        python = {
          format = "[$symbol$version]($style) ";
          style = "bold yellow";
          symbol = "🐍 ";
        };

        username = {
          format = "[$user]($style) ";
          style_user = "bold dimmed blue";
          style_root = "bold red";
          show_always = false;
        };

        hostname = {
          format = "[$hostname]($style) ";
          style = "bold dimmed green";
          ssh_only = true;
        };
      };
    };
  };
}
