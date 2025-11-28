top: {
  configurations.nixos.peach-asus.use = [ "hyprland" ];
  configurations.homeManager.peach.use = [ "hyprland" ];

  homeManager.hyprland.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.wl-clipboard
        pkgs.zenity
        pkgs.swaylock-effects
        pkgs.hyprpolkitagent
      ];
    };

  nixos.hyprland.module =
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
