top: {
  homeManager.helix.module =
    { ... }:
    {
      me.helix.languages =
        # toml
        ''
          [[language]]
          name = "lua"
          indent = { tab-width = 4, unit = "    " }
        '';
    };
}


