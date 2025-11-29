top: {
  configurations.nixos.peach-asus.use = [ "onlineAccounts" ];
  configurations.homeManager.peach.use = [ "onlineAccounts" ];

  nixos.onlineAccounts.module =
    { ... }:
    {
      services.gnome.gnome-keyring.enable = true;
    };

  homeManager.onlineAccounts.module =
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
