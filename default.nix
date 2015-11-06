{ mkDerivation, aeson, atto-lisp, attoparsec, base, bytestring
, parsec, stdenv, stringable
}:
mkDerivation {
  pname = "GetDeps";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  executableHaskellDepends = [
    aeson atto-lisp attoparsec base bytestring parsec stringable
  ];
  homepage = "http://chriswarbo.net/essays/repos/tree-features.html";
  description = "Feature extraction for tree structured data";
  license = stdenv.lib.licenses.gpl3;
}
