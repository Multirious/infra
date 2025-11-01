top:
{
  flake.modules.homeManager.shell =
    { lib, ... }:
    {
      options = {
        shell = {
          unix.interactive = lib.mkOption {
            type = lib.types.lines;
          };
          sh.interactive = lib.mkOption {
            type = lib.types.lines;
          };
          bash.interactive = lib.mkOption {
            type = lib.types.lines;
          };
          zsh.interactive = lib.mkOption {
            type = lib.types.lines;
          };
        };
      };
      config = {
        home.file.".config/shell/unix/tmux_functions".source = ./tmux_functions;
        home.file.".config/shell/unix/nix_functions".source = ./nix_functions;
        home.file.".config/shell/unix/de_functions".source = ./de_functions;

        home.file.".config/shell/unix/interactive".text =
          # sh
          ''
            # If in a terminal
            if [ -t 0 ]; then
              # Disable messsages from other users
              mesg n

              if has-command zoxide; then
                alias cd='z'
              fi

              alias ls='eza'
              alias ll='eza -lg'
              alias lla='eza -lga'
              alias la='eza -a'
              alias l='lla'

              alias grep='grep --color=auto'

              alias clear='clear -x'

              alias ga='git add'
              alias gaa='git add .'
              alias gcm='git commit -m'
              alias gc='git commit'
              alias gs='git status'
              alias gl='git log -20 --pretty=oneline --abbrev-commit --reverse'
              alias gll='git log'
              alias gph='git push'
              alias gpu='git pull'
              alias gd='git diff'

              alias dev='tmux_develop'
              alias ses='tmux_fzf_sessions'

              alias shx='sudo --preserve-env=EDITOR,TERM,TERMINFO,TERMINFO_DIRS,XDG_CONFIG_DIRS,XDG_DATA_DIRS,XDG_CONFIG_HOME,XDG_RUNTIME_DIR,WAYLAND_DISPLAY,DISPLAY,DBUS_SESSION_BUS_ADDRESS hx'
              alias hxdf='hx "$HOME/dotfiles/" && dswitch'
              alias hxnc='shx /etc/nixos'

              alias dswitch='~/dotfiles/switch'
              alias hswitch='home-manager switch'

              alias switchaud='~/system-scripts/switch-audio-device'

              if [ -f "/etc/NIXOS" ]; then
                alias switch='sudo nixos-rebuild switch'
                alias rswitch='sudo nixos-rebuild boot && reboot'
              fi

              . ~/.config/shell/unix/tmux_functions
              . ~/.config/shell/unix/nix_functions
              . ~/.config/shell/unix/de_functions

              export PATH="$PATH:~/scripts"

              if has-command tmux \
                && [ -n "$PS1" ] \
                && [[ ! "$TERM" =~ screen ]] \
                && [[ ! "$TERM" =~ tmux ]] \
                && [ -z "$TMUX" ] \
                && [[ $XDG_SESSION_TYPE != "tty" ]]
              then
                tmux -f ~/.config/tmux/tmux.conf new-session -A -s main ; exit
              fi

              # If colors
              # if [ `tput colors` -ge 8 ]; then
              # fi
            fi
          '';
        home.file.".config/shell/sh/interactive".text =
          # sh
          ''
            . ~/.config/shell/unix/interactive
          '';
        home.file.".config/shell/bash/interactive".text =
          # bash
          ''
            #!/usr/bin/env bash

            . ~/.config/shell/interactive

            [ -d "$XDG_STATE_HOME/bash" ] || mkdir -p "$XDG_STATE_HOME/bash"
            [ -f "$XDG_STATE_HOME/bash/history" ] || touch "$XDG_STATE_HOME/bash/history"

            export HISTFILE="$XDG_STATE_HOME/bash/history"
            export HISTSIZE=1000
            export HISTFILESIZE=1000

            [ -f "$HOME/.bash_history" ] && rm "$HOME/.bash_history"

            if has-command starship; then
              eval "$(starship init bash)"
            fi

            if has-command zoxide; then
              eval "$(zoxide init bash)"
            fi
          '';
        home.file.".config/shell/zsh/interactive".text =
          # zsh
          ''
            #!/usr/bin/env zsh

            source ~/.config/shell/unix/interactive

            [ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
            [ -f "$XDG_STATE_HOME/zsh/history" ] || touch "$XDG_STATE_HOME/zsh/history"

            export HISTFILE="$XDG_STATE_HOME/zsh/history"
            export SAVEHIST="2000"
            export HISTSIZE="2000"

            source ~/.config/shell/zsh/completion.zsh

            if has-command starship; then
              eval "$(starship init zsh)"

              PS2=$'%{\e[90m%}∙∙∙%{\e[0m%} '
            fi

            HYPHEN_INSENSITIVE="true"

            source ~/.config/shell/zsh/plugins.zsh

            # For completions to work, this must be added after compinit is called.
            if has-command zoxide; then
              eval "$(zoxide init zsh)"
            fi

            setopt HIST_EXPIRE_DUPS_FIRST
            setopt HIST_IGNORE_DUPS
            setopt HIST_IGNORE_ALL_DUPS
            setopt HIST_IGNORE_SPACE
            setopt HIST_FIND_NO_DUPS
            setopt HIST_SAVE_NO_DUPS

            if has-command direnv; then
              eval "$(direnv hook zsh)"
            fi
          '';
      };
    };
}
