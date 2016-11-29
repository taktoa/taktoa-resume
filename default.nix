with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "latex-environment";

  #latexPkgs = [
    #  texLive
    #texLiveExtra
    #texLiveCMSuper
    #lmodern
    #tipa
    #];

  buildInputs = [
    git
    zsh
    evince
    gnumake
    pandoc
    python34Packages.pygments
    #(pkgs.texLiveAggregationFun { paths = latexPkgs; })
    (texlive.combine {
      inherit (texlive) scheme-medium collection-xetex;
      inherit (texlive) moderncv tipa fontawesome;
      pkgFilter = pkg: lib.any (x: x) [
        (pkg.tlType == "run")
        (pkg.tlType == "bin")
        (pkg.pname == "fontawesome")
      ];
    })
  ];

  shellHook = ''
      zsh
      exit
  '';
}
