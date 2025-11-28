top: {
  configurations.homeManager.peach.use = [ "recording" ];

  homeManager.recording.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.obs-studio
      ];
    };
}
