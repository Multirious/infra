top: {
  configurations.homeManager.peach.use = [ "passwordManager" ];

  flake.modules.homeManager.passwordManager =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.keepassxc
      ];
    };
}
