top: {
  configurations.homeManager.peach.use = [ "modelEditing" ];

  homeManager.modelEditing.module =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.blender.override {
          # cudaSupport = true;
        })
      ];
    };
}
