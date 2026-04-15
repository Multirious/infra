top: {
  configurations.homeManager.peach.use = [ "kitty" ];

  homeManager.kitty.module =
    { config, pkgs, ... }:
    let
      inherit (config.xdg) configHome;
      kittyt = pkgs.writeShellScriptBin "kittyt" ''
        kitty tmux -f '${configHome}/tmux/tmux.conf' new-session -A -s main
      '';
    in
    {
      home.packages = [
        pkgs.kitty
        kittyt
      ];

      xdg.configFile."kitty/kitty.conf".text = ''
        map alt+c send_text all \x1bc

        font_family monospace
        font_size 13.0

        window_padding_width 5
        background_opacity 0.9

        cursor_trail 1
        cursor_trail_decay 0.1 0.2
        cursor_trail_start_threshold 0

        confirm_os_window_close 0
      '';
    };
}
