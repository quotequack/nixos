# Þose
{ lib, config, pkgs, inputs, system,  ... }:

# Main
{
  # Imports
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  # Settings
  home.username = "quote";
  home.homeDirectory = "/home/quote";
  home.stateVersion = "24.11";

  # Starship config
  programs.starship = {
    enable = true;
  };

  
  # Zen browser
  programs.zen-browser = {
    enable = true;
    profiles.quote = {
      settings = {
        "devtools.debugger.remote-enabled" = true;
        "browser.download.panel.shown" = true;
        "devtools.chrome.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.allow_transparent_browser" = true;
        "zen.widget.linux.transparency" = true;
        "zen.theme.accent-color" = "#8fbcbb";
        "zen.theme.essentials-favicon-bg" = true;
        "zen.theme.gradient.show-custom-colors" = true;
        "zen.view.experimental-rounded-view" = true;
      };
      userChrome = ''
    :root {
      --zen-colors-primary: #3B4252 !important;
      --zen-primary-color: #8fbcbb !important;
      --zen-colors-secondary: #3B4252 !important;
      --zen-colors-tertiary: #434C5E !important;
      --zen-colors-border: #8fbcbb !important;
      --toolbarbutton-icon-fill: #8fbcbb !important;
      --lwt-text-color: #E5E9F0 !important;
      --toolbar-field-color: #E5E9F0 !important;
      --tab-selected-textcolor: #E5E9F0 !important;
      --toolbar-field-focus-color: #E5E9F0 !important;
      --toolbar-color: #E5E9F0 !important;
      --newtab-text-primary-color: #E5E9F0 !important;
      --arrowpanel-color: #E5E9F0 !important;
      --arrowpanel-background: #2E3440 !important;
      --sidebar-text-color: #E5E9F0 !important;
      --lwt-sidebar-text-color: #E5E9F0 !important;
      --lwt-sidebar-background-color: #4C566ABB !important;
      --toolbar-bgcolor: #3B4252 !important;
      --newtab-background-color: #2E3440 !important;
      --zen-themed-toolbar-bg: #434C5ECC !important;
      --zen-main-browser-background: #434C5E88 !important;
      --toolbox-bgcolor-inactive: #434C5E99 !important;
    }

    #permissions-granted-icon {
      color: #434C5E !important;
    }

    .sidebar-placesTree {
      background-color: #2E3440BB !important;
    }

    #zen-workspaces-button {
      background-color: #2E3440BB !important;
    }

    #TabsToolbar {
      background-color: #434C5E99 !important;
    }

    #urlbar-background {
      background-color: #2E3440BB !important;
    }

    .content-shortcuts {
      background-color: #2E3440BB !important;
      border-color: #8fbcbb !important;
    }

    .urlbarView-url {
      color: #8fbcbb !important;
    }

    #zenEditBookmarkPanelFaviconContainer {
      background: #4C566ABB !important;
    }

    #zen-media-controls-toolbar {
      & #zen-media-progress-bar {
        &::-moz-range-track {
          background: #3B4252 !important;
        }
      }
    }

    toolbar .toolbarbutton-1 {
      &:not([disabled]) {
        &:is([open], [checked])
          > :is(
            .toolbarbutton-icon,
            .toolbarbutton-text,
            .toolbarbutton-badge-stack
          ) {
          fill: #4C566A;
        }
      }
    }

    .identity-color-blue {
      --identity-tab-color: #81A1C1 !important;
      --identity-icon-color: #81A1C1 !important;
    }

    .identity-color-turquoise {
      --identity-tab-color: #88C0D0 !important;
      --identity-icon-color: #88C0D0 !important;
    }

    .identity-color-green {
      --identity-tab-color: #A3BE8C !important;
      --identity-icon-color: #A3BE8C !important;
    }

    .identity-color-yellow {
      --identity-tab-color: #EBCB8B !important;
      --identity-icon-color: #EBCB8B !important;
    }

    .identity-color-orange {
      --identity-tab-color: #D08770 !important;
      --identity-icon-color: #D08770 !important;
    }

    .identity-color-red {
      --identity-tab-color: #BF616A !important;
      --identity-icon-color: #BF616A !important;
    }

    .identity-color-pink {
      --identity-tab-color: #B48EAD !important;
      --identity-icon-color: #B48EAD !important;
    }

    .identity-color-purple {
      --identity-tab-color: #5E81AC !important;
      --identity-icon-color: #5E81AC !important;
    }

    hbox#titlebar {
      background-color: #434C5E !important;
    }

    #zen-appcontent-navbar-container {
      background-color: #434C5E !important;
    }
      '';
    };
  };

  # Installs
  home.packages = with pkgs; [
    librewolf
    ardour
    networkmanagerapplet
    icu
    tty-clock
    cava
    cbonsai
    nmap
    unzip
    lmms
    unp 
    lsof
    termshark
    glances
    lshw
    blueman
    zip
    gnome-system-monitor
    python3Packages.xlib
    mangohud
    kitty
    ghostty
    fastfetch
    fzf
    cura-appimage
    midivisualizer
    vulkan-tools
    zoxide
    pipx
    pipewire 
    openboard
    pulseaudioFull
    giada
    audacity
    shipwright
    appimage-run
    jack2
    qjackctl
    i3blocks-gaps
    carla
    helvum
    neovim
    nixd
    vital
    musescore
    ckb-next
    feh
    scrcpy
    gnome-boxes
    mullvad-vpn
    arduino
    arduino-ide
    bluez-experimental
    gimp
    xarchiver
    wireshark
    nil
    wmctrl
    easyeffects
    tor
    vim
    figma-linux
    android-tools
    prismlauncher
    vmpk
    vesktop
    goverlay
    fum
    spotify
    flameshot
    blockbench
    xfce.thunar
    ffmpegthumbnailer
    xfce.tumbler
    steam
    tdrop
    lutris
    vimPlugins.nvchad
    prusa-slicer
    vscode
    shortwave
    weechat-unwrapped
    tmux
    github-desktop
    gpu-screen-recorder-gtk
    gpu-screen-recorder
    vkBasalt
    sherlock
    xclip
    obs-studio
    vlc
    blender
    rofimoji
  ];

  # Vesktop
  programs.vesktop.settings = {
    discordBranch= "canary";
    tray= true;
    openLinksWithElectron= false;
    enableSplashScreen= false;
    staticTitle= true;
  };

  # Mime apps
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
      "inode/directory" = "thunar.desktop";
      "text/plain" = "code.desktop";
    };
  };

  # File configs
  home.file = {
    ".config/picom/picom.conf" = {
      source = ./picom;
    };
    ".config/i3/config" = {
      source = ./i3-config;
    };
    ".config/autostart/steam.desktop".text = ''
        [Desktop Entry]
        Name=Steam
        Exec=steam -nochatui -nofriendsui -silent
        Icon=steam
        Terminal=false
        Type=Application
        Categories=Network;FileTransfer;Game;
        MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
        Actions=Store;Community;Library;Servers;Screenshots;News;Settings;BigPicture;Friends;
        PrefersNonDefaultGPU=true
        X-KDE-RunOnDiscreteGpu=true
      '';
    ".config/starship.toml" = { source = ./starship; };
    ".config/fish/config.fish".text = ''
      if status is-interactive
        starship init fish | source
      end
      set -gx PATH /usr/bin/ $PATH
      zoxide init fish | source
      function fish_greeting
        set_color green
        random choice "Eth ez tum" "wilcom" "HAII" "jst kys"
        set_color white
      end
      set -g fish_key_bindings fish_vi_key_bindings
    '';
    ".config/ghostty/config"= { source = ./ghostty.config; };
  };
  
  # Gtk
  gtk = {
    enable = true;
  };

  # Variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
