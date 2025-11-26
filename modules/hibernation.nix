top: {
  configurations.nixos.peach-asus.use = [ "hibernation" ];
  flake.modules.nixos.hibernation = {
    systemd.services."restart-network" = {
      description = "Restart network after hibernation to fix some issues";
      wantedBy = [
        "hibernate.target"
      ];
      after = [
        "hibernate.target"
      ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "systemctl restart iwd";
      };
    };
  };
}
