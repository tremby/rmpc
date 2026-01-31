{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  packages = with pkgs; [
    cargo
    clippy
    rustc
    rust-analyzer
    (rust-bin.nightly.latest.rustfmt)
  ];
}
