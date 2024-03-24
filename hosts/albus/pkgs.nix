{ config, pkgs, ... }:

{
  imports =
    [
      ../../pkgs/steam.nix
      ../../pkgs/openrgb.nix
      ../../pkgs/sunshine.nix
      ../../pkgs/rpiplay.nix
      ../../pkgs/virt.nix
      ../../pkgs/wine.nix
    ];
  environment.systemPackages = with pkgs; [
     mdadm
     lm_sensors
     steam
     gzdoom
     prismlauncher
     gamemode
     gamescope
     lutris
     input-remapper
     cage
     weston
     killall
     yuzu-mainline
     gnome.nautilus
     streamdeck-ui
     brightnessctl
     (vscode-with-extensions.override {
       vscodeExtensions = with vscode-extensions; [
         bbenoist.nix
         ms-python.python
         ms-azuretools.vscode-docker
         ms-vscode-remote.remote-ssh
       ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
         {
           name = "remote-ssh-edit";
           publisher = "ms-vscode-remote";
           version = "0.47.2";
           sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
         }
       ];
     })
  ];

  services.sunshine.enable = true;
  services.rpiplay.enable = true;
}

