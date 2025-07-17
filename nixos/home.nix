{
  config,
  inputs,
  pkgs,
  nix-colors,
  nixvim,
  bsp-casefolding-workaround,
  lib,
  ...
}:

{
  imports = [
    nix-colors.homeManagerModules.default
    nixvim.homeManagerModules.nixvim
    bsp-casefolding-workaround.nixosModules.default
  ];

  colorScheme = nix-colors.colorSchemes.nord;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "srp";
  home.homeDirectory = "/home/srp";
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.npm-packages/bin"
    "$HOME/.flutter/flutter/bin"
  ];

  news.display = "silent";
  news.json = lib.mkForce { };
  news.entries = lib.mkForce [ ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      eval "$(starship init zsh)"
    '';

    shellAliases = {
      vim = "nvim";
      grep = "rg";
      cat = "bat";
      ls = "eza";
      ssh = "kitten ssh";
      yarn = "corepack yarn";
      yarnpkg = "corepack yarnpkg";
      pnpm = "corepack pnpm";
      pnpx = "corepack pnpx";
      npm = "corepack npm";
      npx = "corepack npx";
    };
  };

  # note: nixvim needs to be enabled in the NixOS
  # configs *before* it can be enabled here
  programs.nixvim = {
    enable = true;

    plugins.lualine.enable = true;
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "macchiato";
      };
    };
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
  };

  services.emacs.enable = true;

  programs.git = {
    enable = true;
    userEmail = "me@srp.life";
    userName = "Seraphim R. Pardee";
    extraConfig = {
      credential.helper = "store";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_BIN_HOME = "$HOME/.local/bin";
    XDG_MUSIC_DIR = "$HOME/music";
    XDG_DESKTOP_DIR = "$HOME";
    XDG_DOCUMENTS_DIR = "$HOME/doc";
    XDG_DOWNLOAD_DIR = "$HOME/dl";
    XDG_PICTURES_DIR = "$HOME/img";
    XDG_PUBLICSHARE_DIR = "$HOME/pub";
    XDG_TEMPLATES_DIR = "$HOME/tmpl";
    XDG_VIDEOS_DIR = "$HOME/vid";
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    SSH_AGENT_SOCK = "/run/user/1000/keyring/ssh";
    XCURSOR_SIZE = "30";
    XCURSOR_THEME = "Catppuccin Macchiato Mauve";
    HYPRCURSOR_SIZE = "30";
    HYPRCURSOR_THEME = "Catppuccin Macchiato Mauve";
    NODE_PATH = "~/.npm-packages/lib/node_modules";
    CHROME_EXECUTABLE = "/run/current-system/sw/bin/brave";
  };

  programs.kitty = with pkgs; {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    themeFile = "Catppuccin-Macchiato";
    # extraConfig = "include themes/Phosphor_Dark_Amber.conf";
  };

  programs.starship.enable = true;

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    settings.device_config = [
      {
        id_uuid = "EA3850B038507D8F";
        ignore = false;
        automount = true;
        options = [
          "uid=1000"
          "rw"
          "exec"
          "umask=000"
        ];
      }
      {
        id_uuid = "72CC3D9BCC3D5B15";
        ignore = false;
        automount = true;
        options = [
          "uid=1000"
          "rw"
          "exec"
          "umask=000"
        ];
      }
    ];
  };

  gtk.iconTheme.package = pkgs.catppuccin-papirus-folders.override {
    flavor = "macchiato";
    accent = "mauve";
  };

  services.easyeffects.enable = true;

  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#8aadf4";
        separator_color = "frame";
        font = "JetBrains Mono Regular 11";
        corner_radius = 5;
        offset = "(20, 5)";
        origin = "top-right";
        notification_limit = 4;
        gap_size = 7;
        frame_width = 2;
        width = "(0, 700)";
        height = "(0, 100)";
        monitor = 0;
        show_indicators = "no";
        highlight = "#8aadf4";
      };

      urgency_low = {
        background = "#24273a";
        foreground = "#cad3f5";
      };

      urgency_normal = {
        background = "#24273a";
        foreground = "#cad3f5";
      };

      urgency_critical = {
        background = "#24273a";
        foreground = "#cad3f5";
        frame_color = "#f5a97f";
      };
    };
  };

  services.bsp-casefolding-workaround = {
    enable = true;

    watch_dirs = [
      "/home/srp/media/Second M.2/SteamLibrary/steamapps/common/Counter-Strike Source/cstrike/download"
    ];
  };

  programs.waybar = {
    enable = true;
    style = ./config/waybar/waybar-style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "idle_inhibitor"
          "network"
          "pulseaudio"
          "mpris"
          "tray"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
          persistent-workspaces = {
            "*" = 6;
          };
        };

        clock = {
          format = "{:%A, %B %d  %I:%M %p}";
          tooltip = false;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        network = {
          interface = "wlp15s0";
          format-wifi = "󰖩";
          format-ethernet = "󰈁";
          tooltip-format = "{essid} ({signalStrength}%) on {ifname}";
          format-disconnected = "󰌙";
        };

        pulseaudio = {
          scroll-step = 1;
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        mpris = {
          format-playing = "{player_icon} Playing";
          format-paused = "{player_icon} Paused";
          format-stopped = "{player_icon}";
          interval = 1;
          #max-length = 40;
          player-icons = {
            spotify = "";
            Plexamp = "󰚺";
            default = "🎜";
          };
          status-icons = {
            "paused" = "⏸";
          };
          #tooltip-with-markup = true;
          #tooltip-format-playing = "<big>{artist}</big>\n{title}\n<small>{album}\n{position}/{length}</small>";
          tooltip-format-playing = "{artist}\n\n{title}\n{album}\n\n{position}/{length}";
          tooltip-format-paused = "{artist}\n\n{title}\n{album}\n\n{position}/{length}";
          player = "Plexamp";
          ignored-players = [
            "firefox"
            "brave"
          ];
        };

        tray = {
          spacing = 5;
        };

        "custom/power" = {
          format = " ⏻ ";
          tooltip = false;
          menu = "on-click";
          menu-file = ./config/waybar/waybar-power-menu.xml;
          menu-actions = {
            shutdown = "poweroff";
            reboot = "reboot";
            lock = "hyprlock";
            suspend = "systemctl suspend";
            hibernate = "systemctl hibernate";
          };
        };
      };
    };
  };

  services.playerctld.enable = true;

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = true;

      preload = [
        "$HOME/img/nixos.png"
        "$HOME/img/osf-024-static-wallpaper.png"
        "$HOME/img/nix-black-4k.png"
        "$HOME/img/basement.jpg"
        "$HOME/img/02-monestary_catppuccin-macchiato.jpg"
      ];
      wallpaper = [ ", $HOME/img/02-monestary_catppuccin-macchiato.jpg" ];
    };
  };

  programs.hyprlock = {
    enable = true;
    extraConfig = ''${builtins.readFile ./config/hypr/hyprlock.conf}'';
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    extraConfig = ''${builtins.readFile ./config/hypr/hyprland.conf}'';
    plugins = [
      inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
    ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
