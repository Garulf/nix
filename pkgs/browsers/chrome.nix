{ pkgs, lib, ...}:

{
  programs.google-chrome = {
    enable = true;
    version = "stable";
    package = pkgs.google-chrome;
  };
}