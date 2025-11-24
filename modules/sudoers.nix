top: {
  configurations.nixos.peach-asus.use = [ "sudoers" ];

  flake.modules.nixos.sudoers =
    { ... }:
    {
      security.sudo.extraConfig = "#includedir /etc/sudoers.d";
    };
}
