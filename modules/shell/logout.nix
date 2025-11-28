top: {
  homeManager.shell.module =
    { config, lib, ... }:
    let
      inherit (config.xdg) configHome;
    in
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
            . ${configHome}/shell/unix/logout
          '';
        xdg.configFile."shell/zsh/logout".text =
          # zsh
          ''
            . ${configHome}/shell/unix/logout
          '';
      };
    };
}
