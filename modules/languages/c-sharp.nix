top: {
  homeManager.helix.module =
    { ... }:
    {
      me.helix.languages =
        # toml
        ''
          [[language]]
          name = "c-sharp"
          indent = { tab-width = 4, unit = "    " }
        '';
    };
}
