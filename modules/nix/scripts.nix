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
      me.scripts."debug-derivative".source = ./debug-derivative;
    };
}
