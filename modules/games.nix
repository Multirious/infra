top: {
  configurations.homeManager.peach.use = [ "games" ];

  homeManager.games.module =
    {
      config,
      pkgs,
      ...
    }:
    let
      steam = (
        pkgs.steam.override {
          extraEnv.HOME = "${config.xdg.dataHome}/steam";
          extraPkgs = pkgs: config.fonts.packages;
        }
      );
    in
    {
      home.packages = [
        steam
        pkgs.protontricks
        pkgs.prismlauncher
        # top.inputs.noita_entangled_worlds.packages.${pkgs.stdenv.system}.noita-proxy
      ];
      xdg.dataFile."Steam/compatibilitytools.d/GE-Proton10-25".source = fetchTarball {
        url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton10-25/GE-Proton10-25.tar.gz";
        sha256 = "0jb3j9ida2962nmpihpjbp5da70q20hls1r0sn17pdii0ghjiaa4";
      };
    };
}
