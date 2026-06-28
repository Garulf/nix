{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports =
    [ 
      ../../pkgs/neovim.nix
    ];
  
  environment.systemPackages = with pkgs; [
    vscode
    python3Full
    pipx
    gnumake
  ];
}
