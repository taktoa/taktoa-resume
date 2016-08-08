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
    gnumake
    pandoc
    python34Packages.pygments
    #(pkgs.texLiveAggregationFun { paths = latexPkgs; })
    (texlive.combine {
      inherit (texlive) scheme-full collection-xetex moderncv
                        tipa fontawesome;
     })
  ];

  #shellHook = ''
  #IN_NIX="nix" zsh
  #exit
  #'';
}
