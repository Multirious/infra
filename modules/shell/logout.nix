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
        xdg.configFile."shell/unix/logout".text =
          # sh
          '''';
        xdg.configFile."shell/bash/logout".text =
          # bash
          ''
            . ~/.local/config/shell/unix/logout
          '';
        xdg.configFile."shell/zsh/logout".text =
          # zsh
          ''
            . ~/.local/config/shell/unix/logout
          '';
      };
    };
}
