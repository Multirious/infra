top: {
  configurations.homeManager.peach.use = [ "modelEditing" ];

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
