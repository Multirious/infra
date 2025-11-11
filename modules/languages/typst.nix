top: {
  flake.modules.homeManager.helix =
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


