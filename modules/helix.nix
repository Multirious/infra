top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.helix
  ];

  flake.modules.homeManager.helix =
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
        home.file.".config/helix/config.toml".text = cfg.config;
        home.file.".config/helix/languages.toml".text = cfg.languages;

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

            [keys.normal."C-w"]
            h = "hsplit"

            [keys.normal."+"]
            l = ":lsp-restart"

            [keys.normal.space]
            f = "file_picker_in_current_directory"
            "S-f" = "file_picker"
          '';
        me.helix.languages =
          # toml
          ''
            [language-server.rust-analyzer]
            timeout = 600

            [language-server.rust-analyzer.config]
            checkOnSave = true 
            check.command = "clippy"

            [language-server.godot]
            command = "ncat.exe"
            args = ["127.0.0.1", "6005"]

            [language-server.arduino-language-server]
            command = "arduino-language-server"

            [language-server.nixd]
            command = "nixd"

            [[language]]
            name = "rust"
            language-servers = ["rust-analyzer"]
            formatter = { command = "rustfmt", args = [ "--edition", "2024" ] }

            # [language.debugger]
            # command = "codelldb"
            # name = "codelldb"
            # port-arg = "--port {}"
            # transport = "tcp"

            # [[language.debugger.templates]]
            # name = "binary"
            # request = "launch"

            # [[language.debugger.templates.completion]]
            # completion = "filename"
            # name = "binary"

            # [language.debugger.templates.args]
            # program = "{0}"
            # runInTerminal = true

            [[language]]
            name = "nix"
            language-servers = ["nixd"]
            # comment-tokens = "//"
            block-comment-tokens = { start = "/*", end = "*/" }
            formatter = { command = "nixfmt" }

            [[language]]
            name = "gdscript"
            language-servers = ["godot"]

            [[language]]
            name = "arduino"
            scope = "source.arduino"
            injection-regex = "arduino"
            file-types = ["ino", "cpp", "h"]
            comment-token = "//"
            roots = ["sketch.yaml"]
            language-servers = ["arduino-language-server"]
            indent = { tab-width = 4, unit = "    " }
            auto-format = true

            [language.formatter]
            command = "clang-format"

            [[language]]
            name = "lua"
            indent = { tab-width = 4, unit = "    " }

            [[language]]
            name = "c"
            indent = { tab-width = 4, unit = "    " }

            [[language]]
            name = "bash"
            file-types = [
              "sh",
              "bash",
              "ash",
              "dash",
              "ksh",
              "mksh",
              "zsh",
              "zshenv",
              "zlogin",
              "zlogout",
              "zprofile",
              "zshrc",
              "eclass",
              "ebuild",
              "bazelrc",
              "Renviron",
              "zsh-theme",
              "cshrc",
              "tcshrc",
              "bashrc_Apple_Terminal",
              "zshrc_Apple_Terminal",
              { glob = "i3/config" },
              { glob = "sway/config" },
              { glob = "tmux.conf" },
              { glob = ".bash_history" },
              { glob = ".bash_login" },
              { glob = ".bash_logout" },
              { glob = ".bash_profile" },
              { glob = ".bashrc" },
              { glob = ".profile" },
              { glob = ".zshenv" },
              { glob = ".zlogin" },
              { glob = ".zlogout" },
              { glob = ".zprofile" },
              { glob = ".zshrc" },
              { glob = ".zimrc" },
              { glob = "APKBUILD" },
              { glob = ".bash_aliases" },
              { glob = ".Renviron" },
              { glob = ".xprofile" },
              { glob = ".xsession" },
              { glob = ".xsessionrc" },
              { glob = ".yashrc" },
              { glob = ".yash_profile" },
              { glob = ".hushlogin" },
            ]

            [[language]]
            name = "typst"
            soft-wrap.enable = true
            soft-wrap.wrap-at-text-width = true

            [[language]]
            name = "markdown"
            soft-wrap.enable = true
            soft-wrap.wrap-at-text-width = true

            [[grammar]]
            name = "cpp"
            source = { git = "https://github.com/tree-sitter/tree-sitter-cpp", rev = "a90f170f92d5d70e7c2d4183c146e61ba5f3a457" }

            [[grammar]]
            name = "arduino"
            source = { git = "https://github.com/ObserverOfTime/tree-sitter-arduino", rev = "db929fc6822b9b9e1211678d508f187894ce0345" }
          '';
      };

    };
}
