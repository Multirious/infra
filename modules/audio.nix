top: {
  configurations.nixos.peach-asus.module.imports = [
    top.config.flake.modules.nixos.audio
  ];

  flake.modules.nixos.audio = {
    services.pipewire.enable = true;
    services.pipewire.pulse.enable = true;
    security.pam.loginLimits = [
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "95";
      }
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
    ];
  };
}
