top: {
  configurations.homeManager.peach.use = [ "tmux" ];

  homeManager.tmux.module =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.tmux ];
    };
}
