{
  description = "binary representation for simple data structures";
  inputs = {
    utils.url = "github:vale981/hiro-flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, utils, nixpkgs, ... }:
    (utils.lib.poetry2nixWrapper nixpkgs inputs {
      name = "binfootprint";
      poetryArgs = {
        projectDir = ./.;
      };
    });
}
