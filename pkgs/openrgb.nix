{ pkgs, lib, ...}:

{

  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

  environment.systemPackages = with pkgs; [
    openrgb
  ];
  systemd.user.services.openrgb = {
    description = "Launches Openrgb on login.";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "5";
      ExecStart = "${pkgs.openrgb-with-all-plugins}/bin/openrgb --server";
    };
  };

  environment.etc."systemd/system-sleep/openrgb.sh".source =
    pkgs.writeShellScript "openrgb.sh" ''
      if [ "$1" = "pre" ]; then
        ${pkgs.openrgb}/bin/openrgb -c 000000
      elif [ "$1" = "post" ]; then
        ${pkgs.openrgb}/bin/openrgb -c ffffff
      fi
    '';
  services.udev.extraRules = ''
    #---------------------------------------------------------------#
    # Asus AURA Core - DetectAsusAuraCoreControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1854", TAG+="uaccess", TAG+="ASUS_Aura_Core"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1866", TAG+="uaccess", TAG+="ASUS_Aura_Core"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1869", TAG+="uaccess", TAG+="ASUS_Aura_Core"
    #---------------------------------------------------------------#
    # Asus Aura USB - DetectAsusAuraUSBTerminal
    #---------------------------------------------------------------#
    # SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1889", TAG+="uaccess", TAG+="ASUS_ROG_AURA_Terminal"
    #---------------------------------------------------------------#
    # Asus Aura USB - DetectAsusAuraUSBAddressable
    #---------------------------------------------------------------#
    # SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1867", TAG+="uaccess", TAG+="ASUS_Aura_Addressable"
    # SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1872", TAG+="uaccess", TAG+="ASUS_Aura_Addressable"
    # SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="18a3", TAG+="uaccess", TAG+="ASUS_Aura_Addressable"
    # SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="18a5", TAG+="uaccess", TAG+="ASUS_Aura_Addressable"
    #---------------------------------------------------------------#
    # Asus Aura USB - DetectAsusAuraUSBMotherboards
    #---------------------------------------------------------------#
    # SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="18f3", TAG+="uaccess", TAG+="ASUS_Aura_Motherboard"
    # SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1939", TAG+="uaccess", TAG+="ASUS_Aura_Motherboard"
    # SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="19af", TAG+="uaccess", TAG+="ASUS_Aura_Motherboard"
    #---------------------------------------------------------------#
    # Corsair Commander Core - DetectCorsairCapellixHIDControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c1c", TAG+="uaccess", TAG+="Corsair_Commander_Core"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c32", TAG+="uaccess", TAG+="Corsair_Commander_Core"
    #---------------------------------------------------------------#
    # Corsair Hydro Series H100i v2 AIO - DetectCorsairHydro2Controllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c09", TAG+="uaccess", TAG+="Corsair_H100i_v2"
    #---------------------------------------------------------------#
    # Corsair Hydro - DetectCorsairHydroControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="x0c12", TAG+="uaccess", TAG+="Corsair_Hydro_Series"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="x0c13", TAG+="uaccess", TAG+="Corsair_Hydro_Series"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="x0c15", TAG+="uaccess", TAG+="Corsair_Hydro_Series"
    #---------------------------------------------------------------#
    # Corsair Hydro Platinum - DetectCorsairHydroPlatinumControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c18", TAG+="uaccess", TAG+="Corsair_Hydro_H100i_Platinum"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c19", TAG+="uaccess", TAG+="Corsair_Hydro_H100i_Platinum_SE"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c17", TAG+="uaccess", TAG+="Corsair_Hydro_H115i_Platinum"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c29", TAG+="uaccess", TAG+="Corsair_Hydro_H60i_Pro_XT"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c20", TAG+="uaccess", TAG+="Corsair_Hydro_H100i_Pro_XT"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c2d", TAG+="uaccess", TAG+="Corsair_Hydro_H100i_Pro_XT_v2"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c21", TAG+="uaccess", TAG+="Corsair_Hydro_H115i_Pro_XT"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c22", TAG+="uaccess", TAG+="Corsair_Hydro_H150i_Pro_XT"
    #---------------------------------------------------------------#
    # Corsair Lighting Node - DetectCorsairLightingNodeControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c1a", TAG+="uaccess", TAG+="Corsair_Lighting_Node_Core"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c0b", TAG+="uaccess", TAG+="Corsair_Lighting_Node_Pro"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c10", TAG+="uaccess", TAG+="Corsair_Commander_Pro"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c1e", TAG+="uaccess", TAG+="Corsair_LS100_Lighting_Kit"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1d00", TAG+="uaccess", TAG+="Corsair_1000D_Obsidian"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1d04", TAG+="uaccess", TAG+="Corsair_SPEC_OMEGA_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c23", TAG+="uaccess", TAG+="Corsair_LT100"
    #---------------------------------------------------------------#
    # Corsair K100 Keyboard - DetectCorsairK100Controllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b7c", TAG+="uaccess", TAG+="Corsair_K100"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b7d", TAG+="uaccess", TAG+="Corsair_K100"
    #---------------------------------------------------------------#
    # Corsair K55 RGB Pro XT - DetectCorsairK55RGBPROXTControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1ba1", TAG+="uaccess", TAG+="Corsair_K55_RGB_PRO_XT"
    #---------------------------------------------------------------#
    # Corsair K65 Mini - DetectCorsairK65MiniControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1baf", TAG+="uaccess", TAG+="Corsair_K65_Mini"
    #---------------------------------------------------------------#
    # Corsair K95 Platinum XT Keyboard - DetectCorsairK95PlatinumXTControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b89", TAG+="uaccess", TAG+="Corsair_K95_RGB_PLATINUM_XT"
    #---------------------------------------------------------------#
    # Corsair Peripheral - DetectCorsairPeripheralControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b3d", TAG+="uaccess", TAG+="Corsair_K55_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b17", TAG+="uaccess", TAG+="Corsair_K65_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b37", TAG+="uaccess", TAG+="Corsair_K65_LUX_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b39", TAG+="uaccess", TAG+="Corsair_K65_RGB_RAPIDFIRE"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b4f", TAG+="uaccess", TAG+="Corsair_K68_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b13", TAG+="uaccess", TAG+="Corsair_K70_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b36", TAG+="uaccess", TAG+="Corsair_K70_LUX"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b33", TAG+="uaccess", TAG+="Corsair_K70_LUX_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b38", TAG+="uaccess", TAG+="Corsair_K70_RGB_RAPIDFIRE"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b49", TAG+="uaccess", TAG+="Corsair_K70_RGB_MK2"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b6b", TAG+="uaccess", TAG+="Corsair_K70_RGB_MK2_SE"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b55", TAG+="uaccess", TAG+="Corsair_K70_RGB_MK2_Low_Profile"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b11", TAG+="uaccess", TAG+="Corsair_K95_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b2d", TAG+="uaccess", TAG+="Corsair_K95_RGB_PLATINUM"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b20", TAG+="uaccess", TAG+="Corsair_Strafe"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b44", TAG+="uaccess", TAG+="Corsair_Strafe_Red"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b48", TAG+="uaccess", TAG+="Corsair_Strafe_MK2"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b34", TAG+="uaccess", TAG+="Corsair_Glaive_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b74", TAG+="uaccess", TAG+="Corsair_Glaive_RGB_PRO"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b3c", TAG+="uaccess", TAG+="Corsair_Harpoon_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b75", TAG+="uaccess", TAG+="Corsair_Harpoon_RGB_PRO"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b5d", TAG+="uaccess", TAG+="Corsair_Ironclaw_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b12", TAG+="uaccess", TAG+="Corsair_M65"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b2e", TAG+="uaccess", TAG+="Corsair_M65_PRO"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b5a", TAG+="uaccess", TAG+="Corsair_M65_RGB_Elite"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b5c", TAG+="uaccess", TAG+="Corsair_Nightsword"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b1e", TAG+="uaccess", TAG+="Corsair_Scimitar_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b3e", TAG+="uaccess", TAG+="Corsair_Scimitar_PRO_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b8b", TAG+="uaccess", TAG+="Corsair_Scimitar_Elite_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b2f", TAG+="uaccess", TAG+="Corsair_Sabre_RGB"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b3b", TAG+="uaccess", TAG+="Corsair_MM800_RGB_Polaris"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0a34", TAG+="uaccess", TAG+="Corsair_ST100_RGB"
    #---------------------------------------------------------------#
    # Corsair Peripherals V2 Hardware - DetectCorsairV2HardwareControllers
    #---------------------------------------------------------------#
    #---------------------------------------------------------------#
    # Corsair Peripherals V2 Software - DetectCorsairV2SoftwareControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1ba4", TAG+="uaccess", TAG+="Corsair_K55_RGB_PRO"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1ba0", TAG+="uaccess", TAG+="Corsair_K60_RGB_PRO"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1bad", TAG+="uaccess", TAG+="Corsair_K60_RGB_PRO_Low_Profile"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1ba6", TAG+="uaccess", TAG+="Corsair_Ironclaw_Wireless"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b4c", TAG+="uaccess", TAG+="Corsair_Ironclaw_Wireless_Wired"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b70", TAG+="uaccess", TAG+="Corsair_M55_RGB_PRO"
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b9b", TAG+="uaccess", TAG+="Corsair_MM700"
    #---------------------------------------------------------------#
    # Corsair Wireless Peripheral - DetectCorsairWirelessControllers
    #---------------------------------------------------------------#
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="1b6e", TAG+="uaccess", TAG+="Corsair_K57_RGB_Wired"
  '';
}
