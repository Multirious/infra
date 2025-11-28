top: {
  configurations.homeManager.peach.use = [ "screenCapture" ];

  homeManager.screenCapture.module =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.flameshot.override { enableWlrSupport = true; })
      ];
      xdg.configFile."flameshot/flameshot.conf".text =
        # ini
        ''
          [General]
          contrastOpacity=188
          copyPathAfterSave=true
          disabledTrayIcon=false
          saveAsFileExtension=jpg
          savePath=/home/peach/pictures/captures
          savePathFixed=true
          showDesktopNotification=false
          showHelp=false
          showSelectionGeometryHideTime=3000
          useGrimAdapter=false
        '';
    };
}
