top: {
  configurations.nixos.peach-asus.use = [ "picoDev" ];

  nixos.picoDev.module =
    { pkgs, ... }:
    {
      services.udev.packages = [
        (pkgs.writeTextFile {
          name = "69-probe-rs.rules";
          text = builtins.readFile (
            builtins.fetchurl {
              url = "https://probe.rs/files/69-probe-rs.rules";
              sha256 = "sha256:12i970v414225nl6i1szjfxwf5w0wzmw7r1cgzlni6wvjxvnag6a";
            }
          );
          destination = "/etc/udev/rules.d/69-probe-rs.rules";
        })
      ];
    };
}
