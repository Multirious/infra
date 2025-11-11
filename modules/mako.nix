top: {
  flake.modules.homeManager.hyprland.imports = [
    top.config.flake.modules.homeManager.mako
  ];

  flake.modules.homeManager.sway.imports = [
    top.config.flake.modules.homeManager.mako
  ];

  flake.modules.homeManager.mako =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.mako
      ];

      home.file.".config/mako/config".text =
        # ini
        ''
          max-history=20
          sort=+time
          outer-margin=0,0,5
          background-color=#EEEEEE
          text-color=#222222
          font=monospace 11
          border-radius=10
          border-size=0
          default-timeout=30000
          anchor=bottom-right
        '';
    };
}
