top: {
  homeManager.helix.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.nixd
        pkgs.nixfmt-rfc-style
      ];

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
