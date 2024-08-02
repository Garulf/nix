{ config, pkgs, ... }:

{
  imports =
    [
      ../../pkgs/promtail.nix
    ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.X11Forwarding = true;
  };

  nixpkgs.config.allowUnfree = true;

  # programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    git
    x11vnc
    htop
    vim
    neovim
    killall
    unzip
    sshfs
  ];
  fonts = {
    defaultFonts = {
        serif = ["DejaVu Serif"];
        sans-serif = ["DejaVu Sans"];
        monospace = ["DejaVu Sans Mono"];
    };
    packages = with pkgs; [
      font-awesome
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DroidSansMono"
          "Iosevka"
          "JetBrainsMono"
        ];
      })
    ];
  };

  security.polkit.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
            action.id == "org.freedesktop.login1.suspend" ||
            action.id == "org.freedesktop.login1.suspend-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };
}
