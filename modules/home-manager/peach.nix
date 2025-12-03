top: {
  configurations.homeManager.peach = {
    system = "x86_64-linux";
    use = [ "global" ];
    module =
      { ... }:
      {
        home.username = "peach";
        home.homeDirectory = "/home/peach";
        home.stateVersion = "24.05";
      };
  };
}
