{ config, pkgs, ... }: 

{
  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      discord
      python310
      python311
      python312
    ];
  };
}