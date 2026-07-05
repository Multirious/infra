top: {
  homeManager.hyprland.module =
    { config, pkgs, ... }:
    let
      inherit (config.xdg) configHome userDirs;
      scriptsDir = "${configHome}/hypr/scripts";
    in
    {
      home.packages = [
        (pkgs.writeShellScriptBin "screencapturetofile" ''
          filename="${userDirs.pictures}/captures/$(date +'%Y-%m-%d_%H-%M-%S.png')"
          grim -g "$(slurp -d)" "$filename"
          echo "$filename" | wl-copy
        '')
        (pkgs.writeShellScriptBin "screencapture" ''
          grim -g "$(slurp -d)" - | wl-copy
        '')
      ];
      xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;

      me.desktop.which-key.config = {
        menu = [
          {
            key = "s";
            desc = "Special Workspaces";
            submenu = [
              {
                key = "s";
                desc = "Close current workspace";
                cmd = "${scriptsDir}/close-current-special-workspace";
              }
              {
                key = "d";
                desc = "Discord";
                cmd = "hyprctl dispatch 'hl.dsp.workspace.toggle_special(\"discord\")'";
              }
              {
                key = "D";
                desc = "Move to Discord";
                cmd = "hyprctl dispatch 'hl.dsp.move({ workspace = \"special:discord\"})'";
              }
              {
                key = "m";
                desc = "Thunderbird";
                cmd = "hyprctl dispatch 'hl.dsp.workspace.toggle_special(\"thunderbird\")'";
              }
              {
                key = "M";
                desc = "Move to Thunderbird";
                cmd = "hyprctl dispatch 'hl.dsp.move({ workspace = \"special:thunderbird\"})'";
              }
              {
                key = "k";
                desc = "KeepassXC";
                cmd = "hyprctl dispatch 'hl.dsp.workspace.toggle_special(\"keepassxc\")'";
              }
              {
                key = "k";
                desc = "Move to KeepassXC";
                cmd = "hyprctl dispatch 'hl.dsp.move({ workspace = \"special:keepassxc\"})'";
              }
            ];
          }
          {
            key = "m";
            desc = "Monitor";
            submenu = [
              {
                key = "m";
                desc = "Make HDMI Mirror main monitor";
                cmd = ''
                  hyprctl eval '
                    hl.monitor({
                      output = "HDMI-A-1",
                      mode = "preferred",
                      position = "auto",
                      scale = 1,
                      mirror = "eDP-1",
                    })
                  '
                '';
              }
              {
                key = "s";
                desc = "Make HDMI Second Monitor";
                cmd = ''
                  hyprctl eval '
                    hl.monitor({
                      output = "HDMI-A-1",
                      mode = "preferred",
                      position = "auto",
                      scale = 1,
                      mirror = "",
                    })
                  '
                '';
              }
            ];
          }
        ];
      };
    };
}
