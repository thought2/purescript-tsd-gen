{
  description = "TypeScript Declaration File (.d.ts) generator for PureScript";

  inputs.haskellNix.url = "github:input-output-hk/haskell.nix";
  inputs.nixpkgs.follows = "haskellNix/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        overlays = [
          haskellNix.overlay
          (final: prev: {
            pursPsdGen =
              final.haskell-nix.project' {
                src = builtins.path { path = ./.; name = "purs-psd-gen"; };
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
                stack-sha256 = "0j357jhg9yf38v9hz80sbkpmpip1bvs99gf63hdmk5hssbk15n88";
                materialized = ./nix/mat;
              };
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
        flake = pkgs.pursPsdGen.flake { };
      in
      flake // {
        defaultPackage = flake.packages."purescript-tsd-gen:exe:purs-tsd-gen";
      });
}
