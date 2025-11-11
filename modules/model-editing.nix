top: {
  configurations.homeManager.peach.use = m: [ m.modelEditing ];

  flake.modules.homeManager.modelEditing =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.blender.override {
          # cudaSupport = true;
        })
      ];
    };
}
