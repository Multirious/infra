top: {
  flake.modules.homeManager.shell =
    { lib, ... }:
    {
      options = {
        shell = {
          unix.logout = lib.mkOption {
            type = lib.types.lines;
          };
          sh.logout = lib.mkOption {
            type = lib.types.lines;
          };
          bash.logout = lib.mkOption {
            type = lib.types.lines;
          };
          zsh.logout = lib.mkOption {
            type = lib.types.lines;
          };
        };
      };
      config = {
        home.file.".config/shell/unix/logout".text =
          # sh
          '''';
        home.file.".config/shell/bash/logout".text =
          # bash
          ''
            . ~/.config/shell/unix/logout
          '';
        home.file.".config/shell/zsh/logout".text =
          # zsh
          ''
            . ~/.config/shell/unix/logout
          '';
      };
    };
}
