top: {
  homeManager.desktop.module =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    # let
    #   # Type definition from 'anything' with list concatenating hot-glued in
    #   myAnything = lib.mkOptionType {
    #     name = "myAnything";
    #     description = "Anything with list concatenation";
    #     descriptionClass = "noun";
    #     check = value: true;
    #     merge =
    #       loc: defs:
    #       let
    #         getType =
    #           value:
    #           if lib.isAttrs value && lib.isStringLike value then "stringCoercibleSet" else lib.typeOf value;

    #         # Returns the common type of all definitions, throws an error if they
    #         # don't have the same type
    #         commonType = lib.foldl' (
    #           type: def:
    #           if getType def.value == type then
    #             type
    #           else
    #             throw "The option `${lib.showOption loc}' has conflicting option types in ${lib.showFiles (lib.getFiles defs)}"
    #         ) (getType (lib.head defs).value) defs;

    #         mergeFunction =
    #           {
    #             # Recursively merge attribute sets
    #             set = (lib.types.attrsOf myAnything).merge;
    #             # This is the type of packages, only accept a single definition
    #             stringCoercibleSet = lib.option.mergeOneOption;
    #             # Concatnetae list
    #             list = (lib.types.listOf myAnything).merge;
    #             lambda =
    #               loc: defs: arg:
    #               whichkeyConfig.merge (loc ++ [ "<function body>" ]) (
    #                 map (def: {
    #                   file = def.file;
    #                   value = def.value arg;
    #                 }) defs
    #               );
    #             # Otherwise fall back to only allowing all equal definitions
    #           }
    #           .${commonType} or lib.options.mergeEqualOption;
    #       in
    #       mergeFunction loc defs;
    #   };
    # in
    {
      options = {
        me.desktop.which-key.config = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.oneOf [
              (lib.types.listOf lib.types.anything)
              lib.types.anything
            ]
          );
        };
      };
      config = {
        home.packages = [
          pkgs.wlr-which-key
        ];
        xdg.configFile."wlr-which-key/config.yaml".text =
          (lib.generators.toYAML { })
            config.me.desktop.which-key.config;

        me.desktop.which-key.config = {
          font = "RobotoMono Nerd Font 12";
          background = "#282828d0";
          color = "#fbf1c7";
          border = "#8ec07c";
          separator = " ➜ ";
          border_width = 2;
          corner_r = 10;
          padding = 15; # Defaults to corner_r
          # rows_per_column = 5; # No limit by default
          column_padding = 25; # Defaults to padding

          anchor = "center"; # One of center, left, right, top, bottom, bottom-left, top-left, etc.
          # Only relevant when anchor is not center
          # margin_right: 0
          # margin_bottom: 0
          # margin_left: 0
          # margin_top: 0

          # namespace to use for the layer shell surface
          # namespace = "wlr_which_key";

          # # Permits key bindings that conflict with compositor key bindings.
          # # Default is `false`.
          inhibit_compositor_keyboard_shortcuts = true;

          # # Try to guess the correct keyboard layout to use. Default is `false`.
          # auto_kbd_layout: true

          menu = [
            {
              key = "p";
              desc = "Power";
              submenu = [
                {
                  key = "s";
                  desc = "Sleep";
                  cmd = "systemctl suspend";
                }
                {
                  key = "r";
                  desc = "Reboot";
                  cmd = "reboot";
                }
                {
                  key = "o";
                  desc = "Off";
                  cmd = "poweroff";
                }
              ];
            }
            {
              key = "u";
              desc = "Utilities";
              submenu = [
                {
                  key = "p";
                  desc = "Python";
                  cmd = "/home/peach/kitty-helix-prompt/kitty-helix-prompt python /home/peach/kitty-helix-prompt/python-prompt \"print()\" \"6li\"";
                }
              ];
            }
          ];
        };
      };
    };
}
