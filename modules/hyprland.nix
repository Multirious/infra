top: {
  configurations.nixos.peach-asus.module.imports = [
    top.config.flake.modules.nixos.hyprland
  ];

  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.hyprland
  ];

  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.wl-clipboard
        pkgs.zenity
        pkgs.swaylock-effects
        pkgs.hyprpolkitagent
      ];

      home.file.".config/hypr/hyprland.conf".source =./hyprland/hyprland.conf;
    };

  flake.modules.nixos.hyprland =
    { pkgs, ... }:
    {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      xdg.portal.enable = true;
      xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-wlr
      ];
    };
}
