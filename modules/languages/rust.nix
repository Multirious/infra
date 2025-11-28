top: {
  homeManager.helix.module =
    { ... }:
    {
      me.helix.languages =
        # toml
        ''
          [language-server.rust-analyzer]
          timeout = 600

          [language-server.rust-analyzer.config]
          checkOnSave = true 
          check.command = "clippy"

          [[language]]
          name = "rust"
          language-servers = ["rust-analyzer"]
          formatter = { command = "rustfmt", args = [ "--edition", "2024" ] }
        '';
    };
}
