{ pkgs, games ? [ ] }:

map (e: pkgs.callPackage ./. e) games
