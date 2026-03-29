top: {
  configurations.nixos.peach-asus.use = [ "mouseCfg" ];

  nixos.mouseCfg.module =
    { pkgs, ... }:
    let
      rivalcfg = (pkgs.rivalcfg).overridePythonAttrs (final: {
        version = "4.16.1";
        src = pkgs.fetchFromGitHub {
          owner = "flozz";
          repo = "rivalcfg";
          tag = "v${final.version}";
          sha256 = "sha256-axEDRL+G990P1k09ZkGLKJwrfiu7SQDrzrw/VbDnrk8=";
        };
        dependencies = with pkgs.python3Packages; [
          flit
          hidapi
          setuptools
        ];
      });
    in
    {
      environment.systemPackages = [ rivalcfg ];
      services.udev.packages = [
        (pkgs.writeTextFile {
          name = "99-steelseries-rival.rules";
          text = builtins.readFile "${rivalcfg}/lib/udev/rules.d/99-rivalcfg.rules";
          destination = "/etc/udev/rules.d/99-steelseries-rival.rules";
        })
      ];
    };
}
