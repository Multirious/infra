top: {
  flake.modules.homeManager.helix =
    { ... }:
    {
      me.helix.languages =
        # toml
        ''
          [language-server.arduino-language-server]
          command = "arduino-language-server"

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

          [[grammar]]
          name = "arduino"
          source = { git = "https://github.com/ObserverOfTime/tree-sitter-arduino", rev = "db929fc6822b9b9e1211678d508f187894ce0345" }
        '';
    };
}


