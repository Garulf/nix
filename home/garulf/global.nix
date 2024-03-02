{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}: {

  imports = [
    ./cli/zsh.nix
  ];

  home = {
    username = "garulf";
    homeDirectory = "/home/garulf";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Garulf";
    userEmail = "535299+Garulf@users.noreply.github.com";
  };

}