top: {
  configurations.homeManager.peach.use = [ "sops" ];
  homeManager.sops.module =
    { config, pkgs, ... }:
    {
      imports = [
        top.inputs.sops-nix.homeManagerModules.sops
      ];

      # sops = {
      #   age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      #   defaultSopsFile = ../secrets.yaml;
      #   secrets.itchio_api_key = {
      #     mode = "7777"; # wtf is wrong with nix
      #   };
      # };

      # nix.package = pkgs.nix;
      # nix.settings.extra-sandbox-paths = [
      #   "${config.sops.secrets.itchio_api_key.path}"
      # ];
    };
}
