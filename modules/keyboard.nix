top: {
  configurations.nixos.peach-asus.use = [ "keyboard" ];
  configurations.homeManager.peach.use = [ "keyboard" ];

  homeManager.keyboard.module =
    { pkgs, ... }:
    let
      zenity-prompt =
        app:
        pkgs.writeShellScript "zenity-sudo-${app}" ''
          "${pkgs.zenity}/bin/zenity" --password --title='Authorize ${app}'
        '';
      run-with-zenity-sudo =
        name: command:
        pkgs.writeShellScript "${name}-with-zenity-sudo" ''
          export SUDO_ASKPASS="${zenity-prompt name}"
          sudo --askpass --preserve-env "${command}"
        '';
      keypeek = top.inputs.keypeek.packages.${pkgs.stdenv.system}.default;
    in
    {
      home.packages =
        let
          zmk-studio-patched = pkgs.symlinkJoin {
            name = "zmk-studio-patched";
            paths = [ pkgs.zmk-studio ];
            postBuild = ''
              rm "$out/share/applications/ZMK Studio.desktop"
              substitute "${pkgs.zmk-studio}/share/applications/ZMK Studio.desktop" "$out/share/applications/ZMK Studio.desktop" \
                --replace-fail "Exec=zmk-studio" "Exec=${run-with-zenity-sudo "zmk-studio" "${pkgs.zmk-studio}/bin/zmk-studio"}"
            '';
          };
        in
        [
          zmk-studio-patched
          keypeek
        ];

      xdg.desktopEntries."keypeek" = {
        name = "keypeek";
        exec = "${run-with-zenity-sudo "keypeek" "${keypeek}/bin/keypeek"}";
        terminal = false;
      };
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
