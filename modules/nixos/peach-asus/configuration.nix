top: {
  configurations.nixos.peach-asus.module =
    { pkgs, lib, ... }:
    {
      imports = with top.config.flake.modules.nixos; [
        top.inputs.nixos-hardware.nixosModules.asus-fa506ic
        ./_hardware-configuration.nix
        global
        laptop
      ];

      me.battery.label = "BAT1";

      time.timeZone = "Asia/Bangkok";

      security.auditd.enable = true;
      security.audit.rules = [ "-w /home/peach/.config/dconf/user -p wa" ];

      programs.mtr.enable = true;

      programs.gnupg.agent.enable = true;
      programs.gnupg.agent.enableSSHSupport = true;

      services.openssh.enable = true;
      services.logmein-hamachi.enable = true;
      services.flatpak.enable = true;

      users.groups = {
        network = { };
      };
      users.users.peach = {
        description = "Peach";
        isNormalUser = true;
        home = "/home/peach";
        extraGroups = [
          "wheel" # sudo usage
          "network" # editing network
          "scanner" # using scanner
          "audio" # realtime audio
        ];
        shell = pkgs.zsh;
        ignoreShellProgramCheck = true;
      };

      boot.kernelPackages = pkgs.linuxPackages_latest;

      boot.kernelParams = [
        "resume_offset=370688" # Hibernation
      ];
      boot.extraModprobeConfig = ''
        options snd_hda_intel power_save=0
      '';

      # Hibernation
      boot.resumeDevice = "/dev/disk/by-uuid/7b8c4bff-a973-4642-9715-caee58886bc2";
      powerManagement.enable = true;
      swapDevices = [
        {
          device = "/var/lib/swapfile";
          size = 48 * 1024;
        }
      ];

      boot.loader.grub.device = "nodev";
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.supportedFilesystems = [ "ntfs" ];

      networking = {
        hostName = "peach-asus";
        wireless.iwd.enable = true;
        wireless.iwd.settings = {
          IPv6 = {
            Enabled = true;
          };
          Settings = {
            AutoConnect = true;
          };
        };
        wireless.userControlled.enable = true;
        wireless.userControlled.group = "network";
        networkmanager.enable = true;
        networkmanager.wifi.backend = "iwd";
        firewall = {
          enable = true;
          allowedTCPPorts = [
            80 # web
            4242 # lan-mouse

            12975 # logmein hamachi
            32976 # logmein hamachi

            8080 # web test

            10888 # dont starve together
            10998 # dont starve together
            10999 # dont starve together

            443 # ssl
          ];
          allowedUDPPorts = [
            80 # web

            8080 # web test

            10888 # dont starve together
            10998 # dont starve together
            10999 # dont starve together

            17771 # logmein hamachi relay
          ];
          allowPing = true;
        };
        hosts = { };
      };

      # services.samba = {
      #   enable = true;
      #   securityType = "user";
      #   openFirewall = true;
      #   settings = {
      #     global = {
      #       "workgroup" = "WORKGROUP";
      #       "server string" = "smbnix";
      #       "netbios name" = "smbnix";
      #       "security" = "user";
      #       #"use sendfile" = "yes";
      #       #"max protocol" = "smb2";
      #       # note: localhost is the ipv6 localhost ::1
      #       "hosts allow" = "192.168.0. 127.0.0.1 localhost";
      #       "hosts deny" = "0.0.0.0/0";
      #       "guest account" = "nobody";
      #       "map to guest" = "bad user";
      #     };
      #     "public" = {
      #       "path" = "/mnt/Shares/Public";
      #       "browseable" = "yes";
      #       "read only" = "no";
      #       "guest ok" = "yes";
      #       "create mask" = "0644";
      #       "directory mask" = "0755";
      #       "force user" = "username";
      #       "force group" = "groupname";
      #     };
      #     "private" = {
      #       "path" = "/mnt/Shares/Private";
      #       "browseable" = "yes";
      #       "read only" = "no";
      #       "guest ok" = "no";
      #       "create mask" = "0644";
      #       "directory mask" = "0755";
      #       "force user" = "username";
      #       "force group" = "groupname";
      #     };
      #   };
      # };
      # services.samba-wsdd = {
      #   enable = true;
      #   openFirewall = true;
      # };
      # services.avahi = {
      #   enable = true;
      #   openFirewall = true;
      #   nssmdns4 = true;
      #   publish = {
      #     enable = true;
      #     addresses = true;
      #   };
      # };

      fileSystems."/" = lib.mkForce {
        device = "/dev/disk/by-label/NIXROOT";
        fsType = "ext4";
      };
      fileSystems."/boot" = lib.mkForce {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };
    };
}
