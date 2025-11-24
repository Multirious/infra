top: {
  configurations.nixos.peach-asus.use = [ "hyprland" ];
  configurations.homeManager.peach.use = [ "hyprland" ];

  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.wl-clipboard
        pkgs.zenity
        pkgs.swaylock-effects
        pkgs.hyprpolkitagent
      ];
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
