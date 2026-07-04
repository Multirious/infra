top: {
  configurations.homeManager.peach.use = [ "infra" ];

  homeManager.infra.module =
    { pkgs, ... }:
    {
      me.scripts."update".text = ''
        #!/usr/bin/env bash
        sudo -v
        nix flake update --flake ~/infra
        sudo nixos-rebulid boot
        home-manager switch --flake ~/infra
        sudo nix-collect-garbage
      '';
    };
}
