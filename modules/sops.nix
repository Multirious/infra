top: {
  configurations.homeManager.peach.use = [ "sops" ];
  homeManager.sops.module =
    { config, ... }:
    {
      imports = [
        top.inputs.sops-nix.homeManagerModules.sops
      ];

      sops = {
        age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        defaultSopsFile = ../secrets.yaml;
        secrets.itchio_api_key = {
          mode = "0400";
        };
      };
    };
}
