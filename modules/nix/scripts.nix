top: {
  homeManager.nix.module =
    { ... }:
    {
      me.scripts."nix-try".text = ''
        #!/usr/bin/env bash
        package="$1"
        shift
        nix shell "nixpkgs#$package" --command $*
      '';
      me.scripts."nix-view".text = ''
        #!/usr/bin/env bash
        nix-build '<nixpkgs>' --attr "$1" --no-out-link
      '';
      me.scripts."debug-derivative".source = ./debug-derivative;
    };
}
