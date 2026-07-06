top: {
  homeManager.helix.module = { ... }: {
    me.helix.config =
      # toml
      ''
        theme = "catppuccin_mocha_fix"

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

        [editor.auto-save]
        after-delay.enable = true
        after-delay.timeout = 3000 # millis

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
        "C-left" = "jump_view_left"
        "C-right" = "jump_view_right"
        "C-up" = "jump_view_up"
        "C-down" = "jump_view_down"

        [keys.normal."C-w"]
        h = "hsplit"

        [keys.normal]
        "C-h" = "jump_view_left"
        "C-l" = "jump_view_right"
        "C-k" = "jump_view_up"
        "C-j" = "jump_view_down"
        "C-left" = "jump_view_left"
        "C-right" = "jump_view_right"
        "C-up" = "jump_view_up"
        "C-down" = "jump_view_down"

        [keys.normal."+"]
        l = ":lsp-restart"

        [keys.normal.space]
        f = "file_picker_in_current_directory"
        "S-f" = "file_picker"
        # git blame
        B = ":sh git log -n 5 --format='format:%%h (%%an: %%ar) %%s' --no-patch -L%{cursor_line},+1:%{buffer_name}"
      '';
  };
}
