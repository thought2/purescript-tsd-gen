final.haskell-nix.project'
{
  src = ./.;
  compiler-nix-name = "ghc8107";

  shell.tools = {
    cabal = { };
    hlint = { };
    haskell-language-server = { };
  };
  shell.buildInputs = with pkgs; [
    nixpkgs-fmt
  ];
  # shell.crossPlatform = p: [ ];
  stack-sha256 = "sha256-CNkS5tIallkbHMa9lPRe4cZb71waoA/TRsP59KA8ZUg=";
  materialized = let materializedPath = ./nix/mat; in if builtins.pathExists materializedPath then materializedPath else null;
};
