top: {
  configurations.homeManager.peach.use = [ "terminal" ];

  homeManager.terminal.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.kitty
      ];
    };
}
