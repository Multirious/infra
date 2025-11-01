top:
{
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
        home.file.".config/shell/unix/env".text =
          # sh
          ''
            # We need to set $ENV so that if you use shell X as your login shell,
            # and then start "sh" as a non-login interactive shell the startup scripts will
            # correctly run.
            export ENV=~/.config/shell/unix/interactive

            # We also need to set BASH_ENV, which is run for *non-interactive* shells.
            # (unlike $ENV, which is for interactive shells)
            export BASH_ENV=~/.config/shell/bash/env

            . ~/.config/shell/unix/env_functions

            umask 0077
          '';
        home.file.".config/shell/unix/env_functions".text =
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
        home.file.".config/shell/sh/env".text =
          # sh
          ''
            # WARNING: this will not be run for non-login, non-interactive shells.

            # Also, you must run ~/.shell/env, to get $ENV.
            . ~/.config/shell/unix/env
          '';
        home.file.".config/shell/bash/env".text =
          # bash
          ''
            # WARNING: this will $BASH_ENV to get a correct startup sequence
            . ~/.config/shell/unix/env
          '';
        home.file.".config/shell/zsh/env".text =
          # zsh
          ''
            . ~/.config/shell/unix/env
          '';
      };
    };
}
