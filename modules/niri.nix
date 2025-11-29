top: {
  configurations.nixos.peach-asus.use = [ "niri" ];
  configurations.homeManager.peach.use = [ "niri" ];

  homeManager.niri.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.niri
      ];
    };
  nixos.niri.module =
    { ... }:
    {
      environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text =
        # json
        ''
          {
            "rules": [
              {
                "pattern": {
                  "feature": "procname",
                  "matches": "niri"
                },
                "profile": "Limit Free Buffer Pool On Wayland Compositors"
              }
            ],
            "profiles": [
              {
                "name": "Limit Free Buffer Pool On Wayland Compositors",
                "settings": [
                  {
                    "key": "GLVidHeapReuseRatio",
                    "value": 0
                  }
                ]
              }
            ]
          }
        '';
    };
}
