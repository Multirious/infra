top: {
  homeManager.helix.module =
    { ... }:
    {
      me.helix.languages =
        # toml
        ''
          [[language]]
          name = "typst"
          soft-wrap.enable = true
          soft-wrap.wrap-at-text-width = true
        '';
    };
}


