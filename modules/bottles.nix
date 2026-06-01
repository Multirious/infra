top: {
  configurations.homeManager.peach.use = [ "bottles" ];

  homeManager.bottles.module =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        # Skipping tests while upstream sorts it out, revert once
        # Hydra consistently builds openldap green.
        (final: prev: {
          openldap = prev.openldap.overrideAttrs (_: {
            doCheck = false;
          });
        })
      ];
      home.packages = [
        (pkgs.bottles.override {
          removeWarningPopup = true;
        })
      ];
    };
}
