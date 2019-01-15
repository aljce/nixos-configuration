{ mkDerivation, alex, array, async, base, binary, blaze-html, boxes
, bytestring, Cabal, containers, cpphs, data-hash, deepseq
, directory, EdisonCore, edit-distance, emacs, equivalence
, filemanip, filepath, geniplate-mirror, gitrev, happy, hashable
, hashtables, haskeline, ieee754, mtl, murmur-hash, pretty, process
, regex-tdfa, stdenv, stm, strict, template-haskell, text, time
, transformers, unordered-containers, uri-encode, zlib
}:
mkDerivation {
  pname = "Agda";
  version = "2.5.4.1";
  sha256 = "7759aa76936e6a35325c2e186a7546553921775155a426c8edc9a234f58ab72f";
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  setupHaskellDepends = [ base Cabal filemanip filepath process ];
  libraryHaskellDepends = [
    array async base binary blaze-html boxes bytestring containers
    data-hash deepseq directory EdisonCore edit-distance equivalence
    filepath geniplate-mirror gitrev hashable hashtables haskeline
    ieee754 mtl murmur-hash pretty process regex-tdfa stm strict
    template-haskell text time transformers unordered-containers
    uri-encode zlib
  ];
  libraryToolDepends = [ alex cpphs happy ];
  executableHaskellDepends = [ base directory filepath process ];
  executableToolDepends = [ emacs ];
  postInstall = ''
    files=("$data/share/ghc-"*"/"*"-ghc-"*"/Agda-"*"/lib/prim/Agda/"{Primitive.agda,Builtin"/"*.agda})
    for f in "''${files[@]}" ; do
      $out/bin/agda $f
    done
    for f in "''${files[@]}" ; do
      $out/bin/agda -c --no-main $f
    done
    $out/bin/agda-mode compile
  '';
  homepage = "http://wiki.portal.chalmers.se/agda/";
  description = "A dependently typed functional programming language and proof assistant";
  license = "unknown";
}
