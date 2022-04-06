{
  extras = hackage:
    {
      packages = {
        "purescript" = (((hackage.purescript)."0.14.5").revisions).default;
        "purescript-cst" = (((hackage.purescript-cst)."0.4.0.0").revisions).default;
        "language-javascript" = (((hackage.language-javascript)."0.7.0.0").revisions).default;
        purescript-tsd-gen = ./purescript-tsd-gen.nix;
        };
      };
  resolver = "lts-18.23";
  modules = [
    ({ lib, ... }:
      {
        packages = {
          "aeson-pretty" = {
            flags = { "lib-only" = lib.mkOverride 900 true; };
            };
          "haskeline" = { flags = { "terminfo" = lib.mkOverride 900 false; }; };
          "these" = { flags = { "assoc" = lib.mkOverride 900 false; }; };
          "purescript-tsd-gen" = {
            flags = {
              "purescript-cst" = lib.mkOverride 900 true;
              "purescript-ast" = lib.mkOverride 900 false;
              };
            };
          };
        })
    { packages = {}; }
    ({ lib, ... }:
      { planned = lib.mkOverride 900 true; })
    ];
  }