{ pkgs ? import <nixpkgs> {}
, compiler ? "ghc843"
, doc ? true
, extras ? true
}:

with pkgs;


stdenv.mkDerivation {
    name = "netizens-dev";
    buildInputs = [ ghc zlib glibcLocales wget stack postgresql ]
      ++ (if extras then [ vimPlugins.stylish-haskell haskellPackages.apply-refact hlint ] else []);
    LANG = "en_US.UTF-8";
    libraryPkgconfigDepends = [ zlib ];
    shellHook = ''
      export PATH=$PATH:`stack path --local-bin`
      export STACK_ARGS="--system-ghc --no-nix-pure --nix-packages 'zlib fzf moreutils'"
      export IS_NIX_SHELL="true"
      export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive";
      eval $(grep export ${ghc}/bin/ghc)
      alias mkdocs="pushd $PWD/docs && make html && popd"
      alias sb="stack build --fast $STACK_ARGS"
      alias st="stack test --fast $STACK_ARGS"
    '';
}
