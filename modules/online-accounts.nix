top: {
  configurations.nixos.peach-asus.use = [ "online-accounts" ];
  configurations.homeManager.peach.use = [ "online-accounts" ];

  flake.modules.nixos.online-accounts =
    { ... }:
    {
      services.gnome.gnome-keyring.enable = true;
    };

  homeManager.online-accounts.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.gnome-online-accounts-gtk
        pkgs.gnome-online-accounts
      ];
      dbus.packages = [
        pkgs.gnome-online-accounts
      ];
    };
}
