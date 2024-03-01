{ pkgs, lib, ...}:

{
  programs.dconf.profiles = {
      # TODO: Investigate customizing gdm greeter.
      user.databases = [{
        settings = with lib.gvariant; {
          "org/gnome/desktop/interface".color-scheme = "prefer-dark";

          "org/gnome/shell".enabled-extensions = [
            "forge@jmmaranan.com"
          ];

          "org/gnome/desktop/wm/keybindings" = {
            switch-to-workspace-1 = ["<Super>1"];
            switch-to-workspace-2 = ["<Super>2"];
            switch-to-workspace-3 = ["<Super>3"];
            switch-to-workspace-4 = ["<Super>4"];
          };
        };
      }];
    };
  environment.systemPackages = [
  ];
}
