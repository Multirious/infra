top: {
  configurations.homeManager.peach.use = m: [ m.passwordManager ];

  flake.modules.homeManager.passwordManager =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.keepassxc
      ];
    };
}
