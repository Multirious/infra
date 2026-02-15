top: {
  configurations.nixos.peach-asus.use = [ "multimedia" ];
  configurations.homeManager.peach.use = [ "multimedia" ];

  homeManager.multimedia.module =
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
          "audio/mpeg" = [ "vlc.desktop" ];
          "audio/ogg" = [ "vlc.desktop" ];
          "audio/wav" = [ "vlc.desktop" ];
          "audio/webm" = [ "vlc.desktop" ];
          "video/mpeg" = [ "vlc.desktop" ];
          "video/ogg" = [ "vlc.desktop" ];
          "video/webm" = [ "vlc.desktop" ];

          "image/jpeg" = [ "org.nomacs.ImageLounge.desktop" ];
          "image/png" = [ "org.nomacs.ImageLounge.desktop" ];
        };
      };
    };

  nixos.multimedia.module =
    { ... }:
    {
      services.pipewire.enable = true;
      services.pipewire.pulse.enable = true;
    };
}
