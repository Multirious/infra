top: {
  homeManager.helix.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.lua-language-server
      ];

      me.helix.languages =
        # toml
        ''
          [[language]]
          name = "lua"
          indent = { tab-width = 4, unit = "    " }
        '';
    };
}
