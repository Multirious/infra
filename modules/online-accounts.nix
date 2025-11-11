top: {
  configurations.nixos.peach-asus.use = m: [ m.online-accounts ];

  flake.modules.nixos.online-accounts =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.gnome-online-accounts-gtk ];
      services.gnome.gnome-online-accounts.enable = true;
      services.gnome.gnome-keyring.enable = true;
    };
}
