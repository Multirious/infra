top: {
  flake.modules.homeManager.shell =
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
