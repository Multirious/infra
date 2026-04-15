top: {
  configurations.homeManager.peach.use = [ "vscode" ];
  homeManager.vscode.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.vscode
      ];
    };
}
