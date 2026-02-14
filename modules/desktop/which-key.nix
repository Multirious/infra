top: {
  homeManager.desktop.module =
    { pkgs, lib, ... }:
    {
      home.packages = [
        pkgs.wlr-which-key
      ];
      xdg.configFile."wlr-which-key/config.yaml" = lib.generators.toYAML {
        test = "";
      };
    };
}
