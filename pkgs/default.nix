{ self, inputs }:
final: prev: {
  wowtricks = prev.winetricks.override { wine = final.wine-tkg; };

  osu-stable = prev.callPackage ./osu-stable {
    wine = final.wine-tkg;
    winetricks = final.wowtricks;
    inherit (final) winestreamproxy;
  };

  #rocket-league = prev.callPackage ./rocket-league {
  #  wine = final.wine-tkg;
  #  winetricks = final.wowtricks;
  #};

  rocket-league = self.lib.legendaryBuilder {
    pkgs = prev;
    games = [
      {
        name = "Rocket League";
        pname = "rocket-league";
        tweaks = [ "dxvk" "win10" ];
        icon = builtins.fetchurl {
          url = "https://www.pngkey.com/png/full/16-160666_rocket-league-png.png";
          name = "rocket-league.png";
          sha256 = "09n90zvv8i8bk3b620b6qzhj37jsrhmxxf7wqlsgkifs4k2q8qpf";
        };
      }
    ];
  };

  technic-launcher = prev.callPackage ./technic-launcher { };

  winestreamproxy = prev.callPackage ./winestreamproxy { wine = final.wine-tkg; };

  wine-tkg = prev.callPackage ./wine-tkg {
    wine =
      if prev.system == "x86_64-linux"
      then final.wineWowPackages.unstable
      else final.wineUnstable;
    inherit (inputs) tkgPatches oglfPatches;
  };
}
