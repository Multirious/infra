top: {
  # configurations.nixos.peach-asus.module.imports = [
  #   top.config.flake.modules.nixos.virtualbox
  # ];
  
  flake.modules.nixos.virtualbox =
    { ... }:
    {
      virtualisation.virtualbox.host.enable = true;
      virtualisation.virtualbox.guest.vboxsf = true;
      virtualisation.virtualbox.guest.enable = true;
      virtualisation.virtualbox.guest.clipboard = true;

      boot.kernelParams = [
        "kvm.enable_virt_at_load=0"
      ];
    };
}
