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
        secrets.example_key = {
          path = "%r/example_key.txt";
        };
      };
    };
}
