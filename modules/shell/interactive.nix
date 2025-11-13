top: {
  flake.modules.homeManager.shell =
    { config, lib, ... }:
    let
      inherit (config.xdg) configHome stateHome;
      inherit (config.home) homeDirectory;
    in
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
        xdg.configFile."shell/unix/tmux_functions".source = ./tmux_functions;
        xdg.configFile."shell/unix/nix_functions".source = ./nix_functions;
        xdg.configFile."shell/unix/de_functions".source = ./de_functions;

        xdg.configFile."shell/unix/interactive".text =
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
              alias gap='git add -p'
              alias gcm='git commit -m'
              alias gc='git commit'
              alias gs='git status'
              alias gl='git log -20 --pretty=oneline --abbrev-commit'
              alias gll='git log'
              alias gph='git push'
              alias gpu='git pull'
              alias gd='git diff'
              alias gdc='git diff --cached'

              alias dev='tmux_develop'

              alias shx='sudo --preserve-env=EDITOR,TERM,TERMINFO,TERMINFO_DIRS,XDG_CONFIG_DIRS,XDG_DATA_DIRS,XDG_CONFIG_HOME,XDG_RUNTIME_DIR,WAYLAND_DISPLAY,DISPLAY,DBUS_SESSION_BUS_ADDRESS hx'

              alias hxi='hx ${homeDirectory}/infra'
              alias hswitch='home-manager switch --flake ${homeDirectory}/infra'

              alias switchaud='${homeDirectory}/system-scripts/switch-audio-device'

              if [ -f '/etc/NIXOS' ]; then
                alias switch='sudo nixos-rebuild switch'
                alias rswitch='sudo nixos-rebuild boot && reboot'
              fi

              . '${configHome}/shell/unix/tmux_functions'
              . '${configHome}/shell/unix/nix_functions'
              . '${configHome}/shell/unix/de_functions'

              export PATH="$PATH:${configHome}/scripts"

              if has-command tmux \
                && [ -n "$PS1" ] \
                && [[ ! "$TERM" =~ screen ]] \
                && [[ ! "$TERM" =~ tmux ]] \
                && [ -z "$TMUX" ] \
                && [[ $XDG_SESSION_TYPE != "tty" ]]
              then
                tmux -f '${configHome}/tmux/tmux.conf' new-session -A -s main ; exit
              fi

              # If colors
              # if [ `tput colors` -ge 8 ]; then
              # fi
            fi
          '';
        xdg.configFile."shell/sh/interactive".text =
          # sh
          ''
            . ${configHome}/shell/unix/interactive
          '';
        xdg.configFile."shell/bash/interactive".text =
          # bash
          ''
            #!/usr/bin/env bash

            . ${configHome}/shell/interactive

            [ -d "${stateHome}/bash" ] || mkdir -p "${stateHome}/bash"
            [ -f "${stateHome}/bash/history" ] || touch "${stateHome}/bash/history"

            export HISTFILE="${stateHome}/bash/history"
            export HISTSIZE=1000
            export HISTFILESIZE=1000

            [ -f "${homeDirectory}/.bash_history" ] && rm "${homeDirectory}/.bash_history"

            if has-command starship; then
              eval "$(starship init bash)"
            fi

            if has-command zoxide; then
              eval "$(zoxide init bash)"
            fi
          '';
        xdg.configFile."shell/zsh/interactive".text =
          # zsh
          ''
            #!/usr/bin/env zsh

            source ${configHome}/shell/unix/interactive

            [ -d "${stateHome}/zsh" ] || mkdir -p "${stateHome}/zsh"
            [ -f "${stateHome}/zsh/history" ] || touch "${stateHome}/zsh/history"

            export HISTFILE="${stateHome}/zsh/history"
            export SAVEHIST="2000"
            export HISTSIZE="2000"

            source ${configHome}/shell/zsh/completion.zsh

            if has-command starship; then
              eval "$(starship init zsh)"

              PS2=$'%{\e[90m%}∙∙∙%{\e[0m%} '
            fi

            HYPHEN_INSENSITIVE="true"

            source ${configHome}/shell/zsh/plugins.zsh

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
