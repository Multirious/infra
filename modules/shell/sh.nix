top:
{
  flake.modules.homeManager.shell =
    { ... }:
    {
      home.file.".profile".text =
        # sh
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          # WARNING: if you delete .bash_profile, this file becomes part of bash's startup
          # sequence, which means this file suddenly has to cater for two different
          # shells.

          . ~/.config/unix/sh/env
          . ~/.config/unix/sh/login
        '';
    };
}
