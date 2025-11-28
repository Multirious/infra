top: {
  configurations.nixos.peach-asus.use = [ "zsh" ];
  nixos.zsh.module =
    { config, pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.zsh ];
      environment.shells = [ "${pkgs.zsh}/bin/zsh" ];

      environment.etc.zshenv.text = ''
        # /etc/zshenv: DO NOT EDIT -- this file has been generated automatically.
        # This file is read for all shells.

        # Only execute this file once per shell.
        if [ -n "''${__ETC_ZSHENV_SOURCED-}" ]; then return; fi
        __ETC_ZSHENV_SOURCED=1

        if [ -z "''${__NIXOS_SET_ENVIRONMENT_DONE-}" ]; then
            . ${config.system.build.setEnvironment}
        fi

        HELPDIR="${pkgs.zsh}/share/zsh/$ZSH_VERSION/help"

        # Tell zsh how to find installed completions.
        for p in ''${(z)NIX_PROFILES}; do
            fpath=($p/share/zsh/site-functions $p/share/zsh/$ZSH_VERSION/functions $p/share/zsh/vendor-completions $fpath)
        done

        # Read system-wide modifications.
        if test -f /etc/zshenv.local; then
            . /etc/zshenv.local
        fi
      '';

      environment.etc.zprofile.text = ''
        # /etc/zprofile: DO NOT EDIT -- this file has been generated automatically.
        # This file is read for login shells.

        # Only execute this file once per shell.
        if [ -n "''${__ETC_ZPROFILE_SOURCED-}" ]; then return; fi
        __ETC_ZPROFILE_SOURCED=1

        # Read system-wide modifications.
        if test -f /etc/zprofile.local; then
            . /etc/zprofile.local
        fi
      '';

      environment.etc.zshrc.text = ''
        # Only execute this file once per shell.
        if [ -n "$__ETC_ZSHRC_SOURCED" -o -n "$NOSYSZSHRC" ]; then return; fi
        __ETC_ZSHRC_SOURCED=1

        # Alternative method of determining short and full hostname.
        HOST=${config.networking.fqdnOrHostName}

        # Disable some features to support TRAMP.
        if [ "$TERM" = dumb ]; then
            unsetopt zle prompt_cr prompt_subst
            unset RPS1 RPROMPT
            PS1='$ '
            PROMPT='$ '
        fi

        # Read system-wide modifications.
        if test -f /etc/zshrc.local; then
            . /etc/zshrc.local
        fi
      '';
    };

  homeManager.shell.module =
    { config, ... }:
    let
      inherit (config.xdg) configHome;
    in
    {
      home.file.".zshenv".text =
        # zsh
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          . ${configHome}/shell/zsh/env
        '';

      home.file.".zshrc".text =
        # zsh
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          source ${configHome}/shell/zsh/interactive
        '';

      home.file.".zprofile".text =
        # zsh
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          . ${configHome}/shell/zsh/login
        '';
    };
}
