top: {
  configurations.nixos.peach-asus.use = m: [ m.multimedia ];
  configurations.homeManager.peach.use = m: [ m.multimedia ];

  flake.modules.homeManager.multimedia =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.vlc
        pkgs.ffmpeg
        pkgs.qpwgraph
        pkgs.nomacs
        pkgs.yt-dlp
      ];
      xdg.mimeApps = {
        defaultApplications = {
          "audio/mpeg"      = [ "vlc.desktop"       ];
          "audio/ogg"       = [ "vlc.desktop"       ];
          "audio/wav"       = [ "vlc.desktop"       ];
          "audio/webm"      = [ "vlc.desktop"       ];
          "video/mpeg"      = [ "vlc.desktop"       ];
          "video/ogg"       = [ "vlc.desktop"       ];
          "video/webm"      = [ "vlc.desktop"       ];
        };
      };
    };

  flake.modules.nixos.multimedia =
    { ... }:
    {
      services.pipewire.enable = true;
      services.pipewire.pulse.enable = true;
    };
}
