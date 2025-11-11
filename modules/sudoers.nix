top: {
  configurations.nixos.peach-asus.use = m: [ m.sudoers ];

  flake.modules.nixos.sudoers =
    { ... }:
    {
      security.sudo.extraConfig = "#includedir /etc/sudoers.d";
    };
}
