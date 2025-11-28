top: {
  configurations.nixos.peach-asus.use = [ "sudoers" ];

  nixos.sudoers.module =
    { ... }:
    {
      security.sudo.extraConfig = "#includedir /etc/sudoers.d";
    };
}
