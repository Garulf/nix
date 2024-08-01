{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports =
    [ 
      ../../pkgs/neovim.nix
    ];
  
  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
  };

  environment.systemPackages = with pkgs; [
    vscode
    python3Full
    pipx
    gnumake
  ];
}
