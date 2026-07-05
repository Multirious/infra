top: {
  homeManager.hyprland.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.hyprlock
      ];

      xdg.configFile."hypr/hyprlock.conf".text = ''
        background {
          path = /home/peach/.local/share/backgrounds/desert_lake.jpg
          blur_passes = 2
        }

        input-field {
          position = 800, 0
          size = 120, 30
          outline_thickness = 0
          dots_text_format = ◆
          dots_size = 0.25
          dots_spacing = 1

          fade_on_empty = false

          font_family = RobotoMono Nerd Font
          placeholder_text = <span size="10pt"> </span>
          # nerdfont for X, idk why it rendered like that
          fail_text = <span size="10pt"> </span>
          check_text = <span size="10pt"> </span>

          inner_color = rgb(200, 200, 200)

          check_color = rgb(4fa7ff)
          fail_color = rgb(ff644f)
          capslock_color = rgb(200, 200, 200)
          numlock_color = rgb(200, 200, 200)
          bothlock_color = rgb(200, 200, 200)
        }

        label {
          position = 800, 40
          text = $USER
          font_family = RobotoMono Nerd Font
          font_size = 14
          color = rgb(10, 10, 10)

          shadow_passes = 8
        }

        shape {
          position = 0, 0
          size = 1920, 10
          color = rgb(200, 200, 200)

          shadow_passes = 8
        }
      '';
    };
}
