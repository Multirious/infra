top: {
  configurations.nixos.peach-asus.use = [ "nvidia" ];
  nixos.nvidia.module =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
    };
}
