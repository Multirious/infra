top: {
  homeManager.helix.module =
    { ... }:
    {
      me.helix.languages =
        # toml
        ''
          [[language]]
          name = "c"
          indent = { tab-width = 4, unit = "    " }
        '';
    };
}


