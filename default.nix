{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs) lib;
in
pkgs.stdenv.mkDerivation {
  pname = "axshell-audio";
  version = lib.strings.trim (builtins.readFile ./VERSION);

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./Makefile
      ./VERSION
      ./LICENSE
      ./src
      ./test
    ];
  };

  strictDeps = true;
  nativeBuildInputs = [ pkgs.pkg-config ];
  buildInputs = [ pkgs.pipewire ];

  doCheck = true;
  checkTarget = "test";

  makeFlags = [ "PREFIX=$(out)" ];

  meta = {
    description = "PipeWire audio processor for AxShell";
    homepage = "https://github.com/mora1ss/axshell-audio";
    license = lib.licenses.agpl3Only;
    mainProgram = "axshell-audio";
    platforms = lib.platforms.linux;
  };
}
