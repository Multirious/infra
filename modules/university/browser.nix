{ ... }:
{
  homeManager.university.module =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.writeTextFile {
          name = "libre-wolf-university.desktop";
          destination = "/share/applications/librewolf-university.desktop";
          text = ''
            [Desktop Entry]
            Categories=Network;WebBrowser
            Exec=librewolf -p University
            GenericName=University Web Brwoser
            Icon=librewolf
            MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;x-scheme-handler/http;x-scheme-handler/https
            Name=LibreWolf University
            StartupNotify=true
            StartupWMClass=librewolf
            Terminal=false
            Type=Application
            Version=1.4
          '';
        })
      ];
    };
}
