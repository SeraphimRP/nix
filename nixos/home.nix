{
  config,
  inputs,
  pkgs,
  nixvim,
  bsp-casefolding-workaround,
  vicinae,
  lib,
  ...
}:

{
  imports = [
    nixvim.homeModules.nixvim
    bsp-casefolding-workaround.nixosModules.default
    vicinae.homeManagerModules.default
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "srp";
  home.homeDirectory = "/home/srp";
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.npm-packages/bin"
    "$HOME/.flutter/flutter/bin"
    "/usr/local/bin"
  ];

  # this saves us from having to do `home-manager --flake <path> news`
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

    # this serves to have flatpak use installed GTK/cursor/icon themes
    # for themes, they MUST exist in $HOME/.local/share/themes
    # for {icon,cursor}s, it seems to be satisfied with whatever's the standard setup
    loginExtra = ''
      flatpak override --user --filesystem=xdg-data/themes
      flatpak override --user --env=GTK_THEME="Gruvbox-Material-Dark-HIDPI"
      flatpak override --user --env=CURSOR_THEME="Capitaine Cursors (Gruvbox)"
      flatpak override --user --env=ICON_THEME="Gruvbox-Plus-Dark"

      for flatpak in $HOME/.var/app/*/
      do
        confdir="''${flatpak}config/gtk-3.0"

        mkdir -p $confdir
        cp $HOME/.config/gtk-3.0/settings.ini $confdir/settings.ini
      done

      for flatpak in $HOME/.var/app/*/
      do
        confdir="''${flatpak}config/gtk-4.0"

        mkdir -p $confdir
        cp $HOME/.config/gtk-4.0/settings.ini $confdir/settings.ini
      done
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
      run-pkg = "nix-shell -p '(import<nixpkgs>{}).callPackage ./package.nix {}'";
    };
  };

  # note: nixvim needs to be enabled in the NixOS
  # configs *before* it can be enabled here
  programs.nixvim = {
    enable = true;

    plugins.lualine.enable = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

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
    #font.name = "JetBrainsMono Nerd Font";
    font.name = "FiraCodeNF-Reg";
    #themeFile = "noctalia";
    # extraConfig = "include themes/Phosphor_Dark_Amber.conf";
    extraConfig = "include themes/noctalia.conf";
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

  # gtk.iconTheme.package = pkgs.catppuccin-papirus-folders.override {
  #   flavor = "macchiato";
  #   accent = "mauve";
  # };

  services.easyeffects.enable = true;

  services.dunst = {
    enable = false;
    settings = {
      global = {
        frame_color = "#689d6a";
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
        monitor = 1;
        show_indicators = "no";
        highlight = "#689d6a";
      };

      urgency_low = {
        background = "#3c3836";
        foreground = "#ebdbb2";
      };

      urgency_normal = {
        background = "#3c3836";
        foreground = "#ebdbb2";
      };

      urgency_critical = {
        background = "#3c3836";
        foreground = "#ebdbb2";
        frame_color = "#fb4934";
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
    enable = false;
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
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{icon} {volume}% {format_source}";
          format-bluetooth-muted = "{icon}  {format_source}";
          format-muted = "{format_source} ";
          format-source = " {volume}%";
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

        # mpris = {
        #   format-playing = "{player_icon} Playing";
        #   format-paused = "{player_icon} Paused";
        #   format-stopped = "{player_icon}";
        #   interval = 1;
        #   #max-length = 40;
        #   player-icons = {
        #     spotify = "";
        #     Plexamp = "󰚺";
        #     default = "🎜";
        #   };
        #   status-icons = {
        #     "paused" = "⏸";
        #   };
        #   #tooltip-with-markup = true;
        #   #tooltip-format-playing = "<big>{artist}</big>\n{title}\n<small>{album}\n{position}/{length}</small>";
        #   tooltip-format-playing = "{artist}\n\n{title}\n{album}\n\n{position}/{length}";
        #   tooltip-format-paused = "{artist}\n\n{title}\n{album}\n\n{position}/{length}";
        #   player = "Plexamp";
        #   ignored-players = [
        #     "firefox"
        #     "brave"
        #   ];
        # };

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
    enable = false;
    settings = {
      ipc = "on";
      splash = false;

      preload = [
        "$HOME/img/nixos.png"
        "$HOME/img/osf-024-static-wallpaper.png"
        "$HOME/img/nix-black-4k.png"
        "$HOME/img/basement.jpg"
        "$HOME/img/02-monestary_catppuccin-macchiato.jpg"
        "$HOME/img/wallhaven-o31ppl_smoothed_gruvbox.png"
        "$HOME/img/gruvbox-nix_smoothed_gruvbox.png"
        "$HOME/img/lsystem1.png"
        "$HOME/img/math.png"
        "$HOME/img/chromostereopsis.png"
      ];
      wallpaper = [ ", $HOME/img/chromostereopsis.png" ];
    };
  };

  programs.hyprlock = {
    enable = false;
    extraConfig = ''${builtins.readFile ./config/hypr/hyprlock.conf}'';
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "noctalia-shell ipc call lockScreen toggle";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "noctalia-shell ipc call lockScreen toggle";
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
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    extraConfig = ''${builtins.readFile ./config/hypr/hyprland.conf}'';
    plugins = [
      #pkgs.hyprlandPlugins.hyprsplit
      (pkgs.hyprlandPlugins.hyprsplit.overrideAttrs {
        version = "0.51.0";
        src = pkgs.fetchFromGitHub {
          owner = "shezdy";
          repo = "hyprsplit";
          tag = "v0.51.0";
          hash = "sha256-h6vDtBKTfyuA/6frSFcTrdjoAKhwlGBT+nzjoWf9sQE=";
        };
      })
    ];
  };

  programs.mangohud = {
    enable = true;
    settings = {
      preset = 1;
      position = "top-right";
    };
  };

  services.vicinae = {
    enable = true; # default: false
    autoStart = true; # default: true
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
