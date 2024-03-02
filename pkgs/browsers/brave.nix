{ pkgs, lib, ...}:

{
  programs.brave = {
    enable = true;
    package = pkgs.brave;
  };
}