{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, aeson, atto-lisp, attoparsec, base
      , bytestring, parsec, stdenv, stringable
      }:
      mkDerivation {
        pname = "GetDeps";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [
          aeson atto-lisp attoparsec base bytestring parsec stringable
        ];
        executableHaskellDepends = [
          aeson atto-lisp attoparsec base bytestring parsec stringable
        ];
        homepage = "http://chriswarbo.net/essays/repos/tree-features.html";
        description = "Feature extraction for tree structured data";
        license = stdenv.lib.licenses.gpl3;
      };

  haskellPackages = if compiler == "default"
                      then pkgs.haskellPackages
                      else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
