top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.recording
  ];

  flake.modules.homeManager.recording =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.obs-studio
      ];
    };
}
