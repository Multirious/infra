top: {
  configurations.homeManager.peach.use = m: [ m.recording ];

  flake.modules.homeManager.recording =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.obs-studio
      ];
    };
}
