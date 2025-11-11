top: {
  flake.modules.homeManager.helix =
    { ... }:
    {
      me.helix.languages =
        # toml
        ''
          [language-server.godot]
          command = "ncat.exe"
          args = ["127.0.0.1", "6005"]

          [[language]]
          name = "gdscript"
          language-servers = ["godot"]
        '';
    };
}
