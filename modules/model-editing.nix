top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.modelEditing
  ];

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
