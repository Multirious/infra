top: {
  flake.modules.homeManager.shell =
    { lib, ... }:
    {
      options = {
        shell = {
          unix.env = lib.mkOption {
            type = lib.types.lines;
          };
          sh.env = lib.mkOption {
            type = lib.types.lines;
          };
          bash.env = lib.mkOption {
            type = lib.types.lines;
          };
          zsh.env = lib.mkOption {
            type = lib.types.lines;
          };
        };
      };
      config = {
        home.file.".local/config/shell/unix/env".text =
          # sh
          ''
            # We need to set $ENV so that if you use shell X as your login shell,
            # and then start "sh" as a non-login interactive shell the startup scripts will
            # correctly run.
            export ENV=~/.local/config/shell/unix/interactive

            # We also need to set BASH_ENV, which is run for *non-interactive* shells.
            # (unlike $ENV, which is for interactive shells)
            export BASH_ENV=~/.local/config/shell/bash/env

            . ~/.local/config/shell/unix/env_functions

            umask 0077
          '';
        home.file.".local/config/shell/unix/env_functions".text =
          # sh
          ''
            # Usage: try-source filename
            try-source () {
                if [ -r "$1" ]; then
                    . "$1"
                fi
            }

            # Usage: if has-command command
            has-command () {
                command -v "$1" 2>&1 >/dev/null
                return $?
            }
          '';
        home.file.".local/config/shell/sh/env".text =
          # sh
          ''
            # WARNING: this will not be run for non-login, non-interactive shells.

            # Also, you must run ~/.shell/env, to get $ENV.
            . ~/.local/config/shell/unix/env
          '';
        home.file.".local/config/shell/bash/env".text =
          # bash
          ''
            # WARNING: this will $BASH_ENV to get a correct startup sequence
            . ~/.local/config/shell/unix/env
          '';
        home.file.".local/config/shell/zsh/env".text =
          # zsh
          ''
            . ~/.local/config/shell/unix/env
          '';
      };
    };
}
