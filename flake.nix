{
  description = "binary representation for simple data structures";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    mach-nix.url = "github:DavHau/mach-nix";
    flake-utils.url = "github:numtide/flake-utils";
  };

   outputs = { self, nixpkgs, flake-utils, mach-nix }:
     let
       python = "python39";

     in flake-utils.lib.eachSystem ["x86_64-linux"] (system:
       let
         pkgs = nixpkgs.legacyPackages.${system};
         mach-nix-wrapper = import mach-nix { inherit pkgs python;  };

         binfootprint = (mach-nix-wrapper.buildPythonPackage {
           src = ./.;
         });

         pythonShell = mach-nix-wrapper.mkPython {
           packagesExtra = [binfootprint];
         };

       in {
         devShell = pkgs.mkShell {
           buildInputs = with pkgs; [pythonShell black pyright];
         };

         defaultPackage = binfootprint;
       });
}
