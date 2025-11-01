top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.terminal
  ];

  flake.modules.homeManager.terminal =
    { pkgs, ... }: {
      home.packages =
      let
        tmux = pkgs.tmux.overrideAttrs
          (finalAttrs: prevAttrs: {
            version = "865117a05fa1e850da07f67b422a469ee58fe019";
            src = pkgs.fetchFromGitHub {
              owner = "tmux";
              repo = "tmux";
              rev = "865117a05fa1e850da07f67b422a469ee58fe019";
              hash = "sha256-hjiNXGMlUC+jjPvw9a6EXUAGuHbGwRFY0cGi4/K+lak=";
            };
          });
      in [
        pkgs.kitty
        tmux
      ];
    };
}
