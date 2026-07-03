top: {
  homeManager.hyprland.module =
    { config, pkgs, ... }:
    let
      inherit (config.xdg) configHome userDirs;
      scriptsDir = "${configHome}/hypr/scripts";
      screencapturetofile = pkgs.writeScript "screencapturetofile" ''
        filename="${userDirs.pictures}/captures/$(date +'%Y-%m-%d_%H-%M-%S.png')"
        grim -g "$(slurp -d)" "$filename"
        echo "$filename" | wl-copy
      '';
      screencapture = pkgs.writeScript "screencapture" ''
        grim -g "$(slurp -d)" - | wl-copy
      '';
    in
    {
      xdg.configFile."hypr/hyprland.lua".text =
        # lua
        ''
          hl.monitor({
            output = "eDP-1",
            mode = "1920x1080@144",
            position = "0x0",
            scale = 1,
          })
          hl.monitor({
            output = "HDMI-A-1",
            mode = "preferred",
            position = "auto",
            scale = 1,
          })

          local mainMod = "SUPER"

          local terminal = "kittyt"
          local files_browser = "nautilus"
          local left = "left"
          local right = "right"
          local up = "up"
          local down = "down"
          local left2 = "h"
          local down2 = "j"
          local up2 = "k"
          local right2 = "l"

          hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal)) 
          hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("wlr-which-key"))
          hl.bind(mainMod .. " + s", hl.dsp.exec_cmd("wlr-which-key --initial-key s"))
          hl.bind(mainMod .. " + r", hl.dsp.exec_cmd("pkill wofi || wofi"))
          hl.bind(mainMod .. " + bracketleft", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))
          hl.bind(mainMod .. " + bracketright", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))
          hl.bind("Print", hl.dsp.exec_cmd("${screencapture}"))
          hl.bind("CONTROL + Print", hl.dsp.exec_cmd("${screencapturetofile}"))

          hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
          hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
          hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
          hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
          hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
          hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

          hl.bind(mainMod .. " + q", hl.dsp.window.close())
          hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float())
          hl.bind(mainMod .. " + p", hl.dsp.window.pin())
          hl.bind(mainMod .. " + n", function()
            hl.dispatch(hl.dsp.cycle_next())
            hl.dispatch(hl.dsp.alter_zorder({ mode = "top" }))
          end)
          hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
          hl.bind(mainMod .. " + a", hl.dsp.exec_cmd(files_browser))

          local directions = { "right", "left", "up", "down" }
          local directions_keys_1 = { right, left, up, down }
          local directions_keys_2 = { right2, left2, up2, down2 }
          for i = 1,#directions
          do
            hl.bind(mainMod .. " + " .. directions_keys_1[i], hl.dsp.focus({ direction = directions[i] }))
            hl.bind(mainMod .. " + " .. directions_keys_2[i], hl.dsp.focus({ direction = directions[i] }))
            hl.bind(mainMod .. " + SHIFT + " .. directions_keys_1[i], hl.dsp.window.swap({ direction = directions[i] }))
            hl.bind(mainMod .. " + SHIFT + " .. directions_keys_2[i], hl.dsp.window.swap({ direction = directions[i] }))
          end

          for i = 1,10
          do
            local key = i % 10
            hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
            hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
          end

          hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
          hl.bind(mainMod .. " + CONTROL + mouse:272", hl.dsp.window.resize())

          hl.config({
            general = {
            	border_size = 5,
            	resize_on_border = true,
            },
            decoration = {
            	rounding = 20,
            	rounding_power = 1.0,
            	inactive_opacity = 0.97,
            	shadow = {
            		enabled = false,
            	},
            },
            misc = {
              enable_anr_dialog = false,
            	disable_splash_rendering = true,
            	disable_hyprland_logo = true,
            	background_color = "#ffffff",
            	middle_click_paste = false,
            },
            cursor = {
            	no_hardware_cursors = true
            },
            input =  {
            	kb_layout = "us,th",
            	kb_options = "grp:alt_space_toggle",
            },
          })

          hl.curve("expoOut",    { type = "bezier", points = { {0.16, 0.1}, {0.30, 1.0} } })
          hl.curve("cubicInout", { type = "bezier", points = { {0.65, 0.0}, {0.35, 1.0} } })

          hl.animation({ leaf = "windowsIn"       , enabled = true, speed = 4, bezier = "cubicInout" })
          hl.animation({ leaf = "windowsOut"      , enabled = true, speed = 4, bezier = "cubicInout" })
          hl.animation({ leaf = "windowsMove"     , enabled = true, speed = 4, bezier = "expoOut" })
          hl.animation({ leaf = "workspaces"      , enabled = true, speed = 4, bezier = "expoOut"   , style = "slide" })
          hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "cubicInout", style = "slidefadevert 30%" })

          hl.animation({ leaf = "layers"          , enabled = true, speed = 2, bezier = "cubicInout", style = "fade" })
          hl.animation({ leaf = "fadeLayers"      , enabled = true, speed = 2, bezier = "cubicInout" })

          hl.window_rule({ match = { class = "discord", title = "Discord Popout"}, float = true })
          hl.window_rule({ match = { title = "Picture-in-Picture"},                float = true })
          hl.window_rule({ match = { class = "org.kde.dolphin"},                   float = true })
          hl.window_rule({ match = { class = "de.feschber.LanMouse"},              float = true })
          hl.window_rule({ match = { class = "blender"},                           float = true })
          hl.window_rule({ match = { class = "org.gnome.Nautilus"},                float = true })
          hl.window_rule({ match = { class = "Tor Browser"},                       float = true })
          hl.window_rule({ match = { class = "zenity"},                            float = true })

          hl.window_rule({
            name = "Kitty Helix Prompt",
            match = { class = "kitty-helix-prompt" },

            float = true,
            rounding = 0,
            move = { "monitor_w/2-window_w/2", "monitor_h/2-window_h/2" },
            size = { 1000, 480 },
          })

          hl.window_rule({
            name = "Steam Friends List",
            match = {
              class = "steam",
              title = "Friends List",
            },

            float = true,
            size = { 400, 700 },
          })

          hl.window_rule({
            name = "Mega",
            match = {
              class = "nz.co.mega.",
            },
            float = true,
            pin = true,
            size = { 400, 560 },
            move = { "cursor_x", "cursor_y-560" },
          })

          hl.window_rule({
            name = "KeePassXC",
            match = {
              class = "org.keepassxc.KeePassXC",
            },
            no_screen_share = true,
          })

          hl.window_rule({ match = { title = "Noita Entangled Worlds Proxy" }, float = true })

          hl.window_rule({ match = { class = "discord" },                 workspace = "special:discord silent" })
          hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" }, workspace = "special:keepassxc silent" })
          hl.window_rule({ match = { class = "de.feschber.LanMouse" },    workspace = "special:lanmouse silent" })
          hl.window_rule({ match = { class = "geary" },                   workspace = "special:geary silent" })

          hl.layer_rule({ match = { namespace = "notifications" }, animation = "slide" })

          hl.workspace_rule({ workspace = "s[true]", gaps_out = 70 })

          hl.workspace_rule({ workspace = "special:discord", on_created_empty = "discord "})
          hl.workspace_rule({ workspace = "special:keepassxc", on_created_empty = "keepassxc "})
          hl.workspace_rule({ workspace = "special:geary", on_created_empty = "geary "})

          hl.env("GBM_BACKEND", "nvidia-drm")
          hl.env("LIBVA_DRIVER_NAME", "nvidia")
          hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
          hl.env("__GL_VRR_ALLOWED", "0")
          hl.env("__GL_GSYNC_ALLOWED", "0")

          hl.env("GDK_BACKEND", "wayland,x11,*")
          hl.env("QT_QPA_PLATFORM", "wayland;xcb")

          hl.on("hyprland.start", function()
            hl.exec_cmd("hyprpaper")
            hl.exec_cmd("waybar")
            hl.exec_cmd("hypridle")
            hl.exec_cmd("mako")
            hl.exec_cmd("systemctl --user start hyprpolkitagent")

            hl.exec_cmd("udiskie")

            hl.exec_cmd(terminal, { workspace = "1 silent" })
            hl.exec_cmd("geary")
          end)
        '';

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
                cmd = "hyprctl dispatch togglespecialworkspace discord";
              }
              {
                key = "D";
                desc = "Move to Discord";
                cmd = "hyprctl dispatch movetoworkspace special:discord";
              }
              {
                key = "m";
                desc = "Geary";
                cmd = "hyprctl dispatch togglespecialworkspace geary";
              }
              {
                key = "M";
                desc = "Move to Geary";
                cmd = "hyprctl dispatch movetoworkspace special:geary";
              }
              {
                key = "k";
                desc = "KeepassXC";
                cmd = "hyprctl dispatch togglespecialworkspace keepassxc";
              }
              {
                key = "k";
                desc = "Move to KeepassXC";
                cmd = "hyprctl dispatch movetoworkspace special:keepassxc";
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
                cmd = "hyprctl keyword monitor HDMI-A-1, preferred, auto, 1, mirror, eDP-1";
              }
              {
                key = "s";
                desc = "Make HDMI Second Monitor";
                cmd = "hyprctl keyword monitor HDMI-A-1, preferred, auto, 1";
              }
            ];
          }
        ];
      };
    };
}
