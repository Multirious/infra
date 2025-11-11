top: {
  flake.modules.homeManager.helix =
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


