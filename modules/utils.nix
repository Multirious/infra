top: {
  configurations.homeManager.peach.use = m: [ m.utils ];

  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.fastfetch
        pkgs.curl
        pkgs.xz
        pkgs.zoxide
        pkgs.fzf
        pkgs.eza
        pkgs.tldr
        pkgs.file
        pkgs.direnv
        pkgs.jq
        pkgs.wget
        pkgs.btop
        pkgs.scooter
        pkgs.zbar
      ];
    };
}
