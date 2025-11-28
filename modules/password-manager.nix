top: {
  configurations.homeManager.peach.use = [ "passwordManager" ];

  homeManager.passwordManager.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.keepassxc
      ];
    };
}
