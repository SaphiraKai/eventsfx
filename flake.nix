{
  description = "A lightweight daemon for adding UI interaction sounds on input events";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        effectsfx = pkgs.rustPlatform.buildRustPackage rec {
          pname = "eventsfx";
          version = "0.1.0";
          src = ./.;

          cargoLock = {
            lockFile = ./Cargo.lock;
          };

          postInstall = ''
            install -Dm 644 $src/audio/* -t $out/share/eventsfx/audio/
          '';

          buildInputs = with pkgs; [
            alsa-lib
            systemd
            libinput
            bash
            copyDesktopItems
          ];

          nativeBuildInputs = with pkgs; [
            pkg-config
          ];
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cargo
            rustc
            rustfmt
            nixd
            pkg-config
            alsa-lib
            systemd
            libinput
            bash
            effectsfx
          ];
        };

        packages = {
          default = effectsfx;
          effectsfx = effectsfx;
        };
      }
    );
}
