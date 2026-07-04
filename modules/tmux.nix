top: {
  configurations.homeManager.peach.use = [ "tmux" ];

  homeManager.tmux.module = { ... }: {
    home.packages = [ pkgs.tmux ];
  };
}
