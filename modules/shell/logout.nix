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
        home.file.".local/config/shell/unix/logout".text =
          # sh
          '''';
        home.file.".local/config/shell/bash/logout".text =
          # bash
          ''
            . ~/.local/config/shell/unix/logout
          '';
        home.file.".local/config/shell/zsh/logout".text =
          # zsh
          ''
            . ~/.local/config/shell/unix/logout
          '';
      };
    };
}
