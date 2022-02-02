{
  description = "TypeScript Declaration File (.d.ts) generator for PureScript";

  inputs.haskellNix.url = "github:input-output-hk/haskell.nix";
  inputs.nixpkgs.follows = "haskellNix/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        overlays = [
          haskellNix.overlay
          (final: prev: {
            helloProject =
              final.haskell-nix.project' {
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
              };
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
        flake = pkgs.helloProject.flake { };
      in
      flake // {
        defaultPackage = flake.packages."purescript-tsd-gen:exe:purs-tsd-gen";
      });
}
