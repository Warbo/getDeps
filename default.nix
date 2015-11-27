{ mkDerivation, aeson, atto-lisp, attoparsec, base, bytestring
, parsec, stdenv, stringable, tasty, tasty-quickcheck
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
  testHaskellDepends = [
    aeson atto-lisp attoparsec base bytestring parsec stringable tasty
    tasty-quickcheck
  ];
  homepage = "http://chriswarbo.net/git/get-deps";
  description = "Feature extraction for tree structured data";
  license = stdenv.lib.licenses.gpl3;
}
