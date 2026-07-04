{
  description = "My personal blog, built with Zola";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "blog";
          src = self;
          buildInputs = with pkgs; [ zola ];
          buildPhase = ''
            zola build
          '';
          installPhase = ''
            cp -r public $out
          '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            zola
          ];
        };
      }
    );
}
