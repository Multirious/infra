top: {
  configurations.homeManager.peach = {
    system = "x86_64-linux";
    module =
      { ... }:
      {
        home.username = "peach";
        home.homeDirectory = "/home/peach";
        imports = [ top.config.flake.modules.homeManager.global ];
      };
  };
}
