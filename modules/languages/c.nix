top: {
  flake.modules.homeManager.helix =
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


