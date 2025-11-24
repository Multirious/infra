top: {
  configurations.homeManager.peach.use = [ "games" ];

  flake.modules.homeManager.games =
    { config, pkgs, ... }:
    {
      home.packages = [
        (pkgs.steam.override {
          extraEnv.HOME = "${config.xdg.dataHome}/steam";
        })
        pkgs.protontricks
        # pkgs.prismlauncher
      ];
      xdg.dataFile."Steam/compatibilitytools.d/GE-Proton10-25".source = builtins.fetchTarball {
        url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton10-25/GE-Proton10-25.tar.gz";
        sha256 = "0jb3j9ida2962nmpihpjbp5da70q20hls1r0sn17pdii0ghjiaa4";
      };
    };
}
