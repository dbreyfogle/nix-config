{ stdenv, bc }:

stdenv.mkDerivation {
  name = "detect-term-background";
  src = ../scripts/detect-term-background;
  dontUnpack = true;
  dontBuild = true;
  buildInputs = [ bc ];
  installPhase = ''
    install -D $src $out/bin/detect-term-background
  '';
}
