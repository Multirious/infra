top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.passwordManager
  ];

  flake.modules.homeManager.passwordManager =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.keepassxc
      ];
    };
}
