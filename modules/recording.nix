top: {
  configurations.homeManager.peach.use = [ "recording" ];

  flake.modules.homeManager.recording =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.obs-studio
      ];
    };
}
