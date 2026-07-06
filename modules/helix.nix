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
      catppuccin_mocha_fix = pkgs.applyPatches {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "helix";
          rev = "91e071bf9b9b2b8ae176a5581fcb61c789c55cab";
          hash = "sha256-F05ohJp7c9Pdnjq8+srfhAt1ogHjjBz50k1ftHOHGVg=";
        };
        patches = [ ./helix/catppuccin_mocha.patch ];
      };
    in
    {
      options = {
        me.helix.config = lib.mkOption { type = lib.types.lines; };
        me.helix.languages = lib.mkOption { type = lib.types.lines; };
      };
      config = {
        home.packages = [
          top.inputs.helix-with-steel.packages.${pkgs.stdenv.system}.helix
        ];
        xdg.configFile."helix/config.toml".text = cfg.config;
        xdg.configFile."helix/languages.toml".text = cfg.languages;
        xdg.configFile."helix/themes/catppuccin_mocha_fix.toml".source =
          "${catppuccin_mocha_fix}/themes/default/catppuccin_mocha.toml";

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
      };
    };
}
