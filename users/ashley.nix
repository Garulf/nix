{ config, pkgs, ... }: 

{
  users.users.ashley = {
    isNormalUser = true;
    description = "Ashley";
  };
}
