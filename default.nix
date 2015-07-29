with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "latex-environment";
  
  latexPkgs = [
    texLive
    texLiveExtra
    texLiveCMSuper
    lmodern
    tipa
  ];
  
  buildInputs = [
    git
    zsh
    gnumake
    haskellngPackages.pandoc
    python34Packages.pygments
    languagetool
    (pkgs.texLiveAggregationFun { paths = latexPkgs; })
  ];

  shellHook = ''
      IN_NIX="nix" zsh
      exit
  '';
}
