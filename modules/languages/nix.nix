top: {
  flake.modules.homeManager.helix =
    { ... }:
    {
      me.helix.languages =
        # toml
        ''
          [language-server.nixd]
          command = "nixd"

          [[language]]
          name = "nix"
          language-servers = [ "nixd" ]
          block-comment-tokens = { start = "/*", end = "*/" }
          formatter = { command = "nixfmt" }
          auto-format = true
        '';
    };
}

