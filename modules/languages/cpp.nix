top: {
  homeManager.helix.module =
    { ... }:
    {
      me.helix.languages =
        # toml
        ''
          [[grammar]]
          name = "cpp"
          source = { git = "https://github.com/tree-sitter/tree-sitter-cpp", rev = "a90f170f92d5d70e7c2d4183c146e61ba5f3a457" }
        '';
    };
}


