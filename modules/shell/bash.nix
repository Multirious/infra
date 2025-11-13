top: {
  flake.modules.homeManager.shell =
    { config, ... }:
    let
      inherit (config.xdg) configHome;
    in
    {
      home.file.".bash_logout".text =
        # bash
        ''
          . ${configHome}/shell/unix/logout
        '';
      home.file.".bashrc".text =
        # bash
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          # this file gets run in two cases:
          # 1. non-login interactive shell
          # 2. remote shell (over ssh or similar)

          # #2 happens when you run "ssh user@host bash" explicitly.
          # in this case, /etc/bash.bashrc has not been previous executed (unlike #1).
          # however, we assume that #2 is a recovery mode, so we don't want to do much.
          # (also, my google-fu didn't find a way to distinguish them)

          . ${configHome}/shell/bash/env
          . ${configHome}/shell/bash/interactive
        '';
      home.file.".bash_profile".text =
        # bash
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          # We need to do two things here:

          # 1. Ensure $XDG_CONFIG_HOME/shell/bash/env gets run first
          . ${configHome}/shell/bash/env

          # 2. Prevent it from being run later, since we need to use $BASH_ENV for
          # non-login non-interactive shells.
          # We don't export it, as we may have a non-login non-interactive shell as
          # a child.
          BASH_ENV=

          # 3. Join the spanish inquisition. ;)
          # so much for only two things...

          # 4. Run $XDG_CONFIG_HOME/shell/bash/login
          . ${configHome}/shell/bash/login

          # 5. Run $XDG_CONFIG_HOME/shell/bash/interactive if this is an interactive shell.
          if [ "$PS1" ]; then
            . ${configHome}/shell/bash/interactive
          fi
        '';
    };
}
