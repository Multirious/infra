top: {
  homeManager.global.module =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.home-manager ];
      nixpkgs.config.allowUnfree = true;
      news.display = "silent";
    };
}
