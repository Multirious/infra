top: {
  configurations.homeManager.peach.use = [ "infra" ];

  homeManager.infra.module =
    { config, pkgs, ... }:
    let
      inherit (config.home) homeDirectory;
      infraDir = "${homeDirectory}/infra";
    in
    {
      me.scripts = {
        "update".text = ''
          #!/usr/bin/env bash
          sudo -v
          nix flake update --flake "${infraDir}"
          sudo nixos-rebulid boot
          home-manager switch --flake "${infraDir}"
          sudo nix-collect-garbage
        '';
        "hswitch".text = ''
          #!/usr/bin/env bash
          home-manager switch --flake "${infraDir}"
        '';
        "switch".text = ''
          #!/usr/bin/env bash
          sudo nixos-rebuild switch --flake "${infraDir}"
        '';
        "rswitch".text = ''
          #!/usr/bin/env bash
          sudo nixos-rebuild switch --flake "${infraDir}" && reboot
        '';
      };
    };
}
