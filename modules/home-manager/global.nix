top: {
  homeManager.global.module =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.home-manager ];
      nixpkgs.config.allowUnfree = true;
      home.stateVersion = "24.05";
      news.display = "silent";
    };
}
