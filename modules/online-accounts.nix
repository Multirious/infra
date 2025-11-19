top: {
  configurations.nixos.peach-asus.use = m: [ m.online-accounts ];
  configurations.homeManager.peach.use = m: [ m.online-accounts ];

  flake.modules.nixos.online-accounts =
    { ... }:
    {
      services.gnome.gnome-keyring.enable = true;
    };

  flake.modules.homeManager.online-accounts =
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
