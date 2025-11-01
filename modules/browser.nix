top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.browser
  ];

  flake.modules.homeManager.browser =
    { config, pkgs, ... }:
    {
      home.packages = 
        let
          librewolf = pkgs.librewolf.overrideAttrs (a:
            {
              buildCommand = a.buildCommand + ''
                wrapProgram "$executablePath" \
                  --set 'HOME' '${config.home.homeDirectory}/.local/share/librewolf'
              '';
            }
          );
          tor-browser = (import (builtins.fetchGit {
            name = "nixpkgs-with-tor-browser-v14.0.9";
            url = "https://github.com/NixOS/nixpkgs/";
            ref = "refs/heads/nixpkgs-unstable";
            rev = "7d7ba194bf834a5194dadfa8f9debcfabaa718bb";
          }) {
            inherit (pkgs) system;
          }).tor-browser;
        in
        [
          tor-browser
          librewolf 
          pkgs.google-chrome
        ];
      xdg.mimeApps = {
        defaultApplications = {
          "application/pdf"          = [ "librewolf.desktop" ];
          "text/html"                = [ "librewolf.desktop" ];
          "x-scheme-handler/http"    = [ "librewolf.desktop" ];
          "x-scheme-handler/https"   = [ "librewolf.desktop" ];
          "x-scheme-handler/about"   = [ "librewolf.desktop" ];
          "x-scheme-handler/unknown" = [ "librewolf.desktop" ];
        };
      };
    };
}
