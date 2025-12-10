top: {
  configurations.homeManager.peach.use = [ "helix" ];

  homeManager.helix.module =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.me.helix;
    in
    {
      options = {
        me.helix.config = lib.mkOption { type = lib.types.lines; };
        me.helix.languages = lib.mkOption { type = lib.types.lines; };
      };
      config = {
        home.packages = [
          (pkgs.helix.overrideAttrs (
            final: prev: {
              patches = prev.patches ++ [
                ./helix/catppuccin_mocha.patch
              ];
            }
          ))
        ];
        xdg.configFile."helix/config.toml".text = cfg.config;
        xdg.configFile."helix/languages.toml".text = cfg.languages;

        xdg.desktopEntries.Helix = {
          name = "Helix";
          genericName = "Text Editor";
          exec = "kitty hx %F";
          comment = "Edit text files";
          type = "Application";
          icon = "helix";
          categories = [
            "Utility"
            "TextEditor"
          ];
          mimeType = [
            "text/english"
            "text/markdown"
            "text/plain"
            "text/x-makefile"
            "text/x-c++hdr"
            "text/x-c++src"
            "text/x-chdr"
            "text/x-csrc"
            "text/x-java"
            "text/x-moc"
            "text/x-pascal"
            "text/x-tcl"
            "text/x-tex"
            "application/x-shellscript"
            "text/x-c"
            "text/x-c++"
          ];
        };
        xdg.mimeApps = {
          defaultApplications = {
            "text/plain" = [ "Helix.desktop" ];
            "text/css" = [ "Helix.desktop" ];
            "text/csv" = [ "Helix.desktop" ];
            "text/html" = [ "Helix.desktop" ];
            "text/markdown" = [ "Helix.desktop" ];
            "text/xml" = [ "Helix.desktop" ];
          };
        };

        me.helix.config =
          # toml
          ''
            theme = "catppuccin_mocha"

            [editor]
            line-number = "relative"
            mouse = false
            scrolloff = 8
            cursorline = true
            idle-timeout = 0
            completion-trigger-len = 0
            rulers = [80, 120]
            color-modes = true
            true-color = true
            popup-border = "all"
            jump-label-alphabet = "fjdkrueivmchgytnbslwoxaqpz"
            end-of-line-diagnostics = "hint"

            [editor.search]
            smart-case = false

            [editor.cursor-shape]
            insert = "bar"
            normal = "block"
            select = "block"

            [editor.file-picker]
            hidden = false

            [editor.whitespace.render]
            space = "none"
            tab = "all"
            newline = "all"

            [editor.whitespace.characters]
            nbsp = "⍽"
            tab = "→"
            newline = "⏎"

            [editor.indent-guides]
            render = true
            character = "╎"

            [editor.inline-diagnostics]
            cursor-line = "error"

            [keys.insert]
            j.k = "normal_mode"
            "C-h" = "jump_view_left"
            "C-l" = "jump_view_right"
            "C-k" = "jump_view_up"
            "C-j" = "jump_view_down"

            [keys.normal."C-w"]
            h = "hsplit"

            [keys.normal]
            "C-h" = "jump_view_left"
            "C-l" = "jump_view_right"
            "C-k" = "jump_view_up"
            "C-j" = "jump_view_down"

            [keys.normal."+"]
            l = ":lsp-restart"

            [keys.normal.space]
            f = "file_picker_in_current_directory"
            "S-f" = "file_picker"
          '';
      };
    };
}
