# Create alternate home directory for programs not following XDG specification.
# Any program using this module must be wrapped with HOME environment variable pointing
# to the fake home directory defined by this module.
top: {
  configurations.homeManager.peach.use = [ "fakeHome" ];
  homeManager.fakeHome.module =
    { config, lib, ... }:
    {
      options = {
        fakeHome = {
          path = lib.mkOption {
            type = lib.types.str;
            default = "${config.xdg.dataHome}/fakehome";
          };
          home = lib.mkOption {
            type = lib.types.lazyAttrsOf lib.types.submodule {
              option = {
                links = lib.mkOption {
                  type = lib.types.lazyAttrsOf lib.types.str;
                  default = { };
                };
              };
            };
            default = { };
          };
        };
      };
      config = {
        # fakeHome.links =
        #   let
        #     inherit (config) xdg;
        #   in
        #   {
        #     ".config" = xdg.configHome;
        #     ".local/state" = xdg.stateHome;
        #     ".local/share" = xdg.dataHome;
        #     ".cache" = xdg.cacheHome;
        #   };
        # home.activation = {
        #   activateFakeHome =
        #     lib.hm.dag.entryAfter [ "writeBoundary" ]
        #       # bash
        #       ''
        #         run { [ -d "${config.fakehome.root}" ] || mkdir -p "${config.fakehome.path}" }
        #         ${builtins.foldl' (
        #           acc: elem:
        #           acc
        #           ++ /* bash */ ''
        #             run { [ -d "${config.fakehome.root}" ] || mkdir -p "${config.fakehome.root}" }
        #           ''
        #         ) "" (config.fakehome.config.fakehome.links)}
        #       '';
        # };
      };
    };
}
