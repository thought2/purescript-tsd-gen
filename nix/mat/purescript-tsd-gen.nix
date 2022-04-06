{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  ({
    flags = { purescript-ast = false; purescript-cst = false; };
    package = {
      specVersion = "1.12";
      identifier = { name = "purescript-tsd-gen"; version = "0.3.0.0"; };
      license = "BSD-3-Clause";
      copyright = "2018-2021 ARATA Mizuki";
      maintainer = "ARATA Mizuki <minorinoki@gmail.com>";
      author = "ARATA Mizuki <minorinoki@gmail.com>";
      homepage = "https://github.com/minoki/purescript-tsd-gen#readme";
      url = "";
      synopsis = "TypeScript Declaration File (.d.ts) generator for PureScript";
      description = "Please see the README on Github at <https://github.com/minoki/purescript-tsd-gen#readme>";
      buildType = "Simple";
      isLocal = true;
      detailLevel = "FullDetails";
      licenseFiles = [];
      dataDir = ".";
      dataFiles = [];
      extraSrcFiles = [ "README.md" "ChangeLog.md" ];
      extraTmpFiles = [];
      extraDocFiles = [];
      };
    components = {
      exes = {
        "purs-tsd-gen" = {
          depends = (([
            (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."optparse-applicative" or (errorHandler.buildDepError "optparse-applicative"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            ] ++ (pkgs.lib).optionals (flags.purescript-cst && !flags.purescript-ast) [
            (hsPkgs."purescript" or (errorHandler.buildDepError "purescript"))
            (hsPkgs."purescript-cst" or (errorHandler.buildDepError "purescript-cst"))
            ]) ++ (pkgs.lib).optionals (flags.purescript-ast && !flags.purescript-cst) [
            (hsPkgs."purescript" or (errorHandler.buildDepError "purescript"))
            (hsPkgs."purescript-ast" or (errorHandler.buildDepError "purescript-ast"))
            ]) ++ (pkgs.lib).optional (!flags.purescript-ast && !flags.purescript-cst) (hsPkgs."purescript" or (errorHandler.buildDepError "purescript"));
          buildable = true;
          modules = [ "Paths_purescript_tsd_gen" ];
          hsSourceDirs = [ "app" "src" ];
          mainPath = (([
            "Main.hs"
            ] ++ (pkgs.lib).optional (flags.purescript-cst && !flags.purescript-ast) "") ++ (pkgs.lib).optional (flags.purescript-ast && !flags.purescript-cst) "") ++ (pkgs.lib).optional (!flags.purescript-ast && !flags.purescript-cst) "";
          };
        };
      tests = {
        "doctests" = {
          depends = (([
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."doctest" or (errorHandler.buildDepError "doctest"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            ] ++ (pkgs.lib).optionals (flags.purescript-cst && !flags.purescript-ast) [
            (hsPkgs."purescript" or (errorHandler.buildDepError "purescript"))
            (hsPkgs."purescript-cst" or (errorHandler.buildDepError "purescript-cst"))
            ]) ++ (pkgs.lib).optionals (flags.purescript-ast && !flags.purescript-cst) [
            (hsPkgs."purescript" or (errorHandler.buildDepError "purescript"))
            (hsPkgs."purescript-ast" or (errorHandler.buildDepError "purescript-ast"))
            ]) ++ (pkgs.lib).optional (!flags.purescript-ast && !flags.purescript-cst) (hsPkgs."purescript" or (errorHandler.buildDepError "purescript"));
          buildable = true;
          modules = [ "Paths_purescript_tsd_gen" ];
          mainPath = [ "doctests.hs" ];
          };
        };
      };
    } // rec { src = (pkgs.lib).mkDefault ./.; }) // {
    cabal-generator = "hpack";
    }