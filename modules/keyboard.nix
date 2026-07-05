top: {
  configurations.nixos.peach-asus.use = [ "keyboard" ];
  configurations.homeManager.peach.use = [ "keyboard" ];

  homeManager.keyboard.module =
    { pkgs, ... }:
    {
      home.packages =
        let
          zenity-prompt = pkgs.writeShellScript "zenity-prompt" ''
            "${pkgs.zenity}/bin/zenity" --password --title='Authorize zmk-studio'
          '';
          run-zmk-studio = pkgs.writeShellScriptBin "run-zmk-studio" ''
            export SUDO_ASKPASS="${zenity-prompt}"
            sudo --askpass --preserve-env "${pkgs.zmk-studio}/bin/zmk-studio"
          '';
          zmk-studio-patched = pkgs.symlinkJoin {
            name = "zmk-studio-patched";
            paths = [ pkgs.zmk-studio ];
            postBuild = ''
              rm "$out/share/applications/ZMK Studio.desktop"
              substitute "${pkgs.zmk-studio}/share/applications/ZMK Studio.desktop" "$out/share/applications/ZMK Studio.desktop" \
                --replace-fail "Exec=zmk-studio" "Exec=run-zmk-studio"
            '';
          };
        in
        [
          run-zmk-studio
          zmk-studio-patched
        ];
    };

  nixos.keyboard.module =
    { ... }:
    {
      i18n.defaultLocale = "en_US.UTF-8";
      console = {
        # font = "Lat2-Terminus16";
        # keyMap = "us";
        # useXkbConfig = true;
      };
      services.xserver.xkb.layout = "us";
      services.xserver.xkb.options = "";
      services.libinput.enable = true;
    };
}
