top: {
  flake.modules.homeManager.shell =
    { config, ... }:
    let
      inherit (config.xdg) configHome;
    in
    {
      home.file.".profile".text =

        # sh
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          # WARNING: if you delete .bash_profile, this file becomes part of bash's startup
          # sequence, which means this file suddenly has to cater for two different
          # shells.

          . ${configHome}/unix/sh/env
          . ${configHome}/unix/sh/login
        '';
    };
}
