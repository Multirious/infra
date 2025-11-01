top: {
  flake.modules.homeManager.hyprland =
    { ... }:
    {
      home.file.".config/hypr/scripts/rename-workspace-menu" = {
        executable = true;
        text =
          # bash
          ''
            #!/usr/bin/env bash

            choices="obsidian
            terminal
            "
            choosen="$(echo -e "$choices" | wofi -d)"
            if [ -z "$choosen" ]; then
              exit
            fi
            current_workspace=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .activeWorkspace.id')
            hyprctl dispatch renameworkspace "$current_workspace" "$choosen"
          '';
      };
      home.file.".config/hypr/scripts/close-current-special-workspace" = {
        executable = true;
        text =
          # bash
          ''
            #!/usr/bin/env bash

            current_special_workspace="$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name')"
            [ -z $current_special_workspace ] && exit
            name="$(printf '%s' "$current_special_workspace" | sed 's/special://')"
            hyprctl dispatch togglespecialworkspace "$name"
          '';
      };
    };
}
