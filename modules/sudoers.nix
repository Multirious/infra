top: {
  configurations.nixos.peach-asus.module.imports = [
    top.config.flake.modules.nixos.sudoers
  ];

  flake.modules.nixos.sudoers =
    { ... }:
    {
      security.sudo.extraConfig = "#includedir /etc/sudoers.d";
    };
}
