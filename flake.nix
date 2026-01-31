{
  description = "Rusty Music Player Client";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };
    in {
      packages = forAllSystems (system: {
        default = (pkgsFor system).callPackage ./default.nix { };
      });
      devShells = forAllSystems (system: {
        default = (pkgsFor system).callPackage ./shell.nix { };
      });
      overlays.default = final: prev: {
        rmpc = self.packages.${prev.system}.default;
      };
    };
}
