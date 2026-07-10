top: {
  configurations.nixos.peach-asus.use = [ "virtualbox" ];

  nixos.virtualbox.module =
    { pkgs, ... }:
    {
      virtualisation.virtualbox = {
        host.enable = true;
        host.package = pkgs.virtualbox.overrideAttrs (
          final: prev: {
            virtualboxVersion = "7.2.12";
            virtualboxSha256 = "sha256-ZKSENnfkIBDneZ6VGIP7vvxWvyvBYuSXDt6gTxQviyU=";
          }
        );
        guest.vboxsf = true;
        guest.enable = true;
        guest.clipboard = true;
      };

      boot.kernelParams = [
        "kvm.enable_virt_at_load=0"
      ];
    };
}
