{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
{
  home.username = "luna";
  home.homeDirectory = "/home/luna";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # basic configuration of git, please change to your own

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.graphite-cursors;
    name = "graphite-dark";
  };

  catppuccin = {
    flavor = "mocha";
    enable = true;
  };
  catppuccin.waybar.enable = false;

  programs.git = {
    enable = true;
    settings.user.name = "Luna Xin";
    settings.user.email = "luna.xin@outlook.com";
    settings = {
      init.defaultBranch = "main";
    };
  };

  programs.jujutsu = {
    enable = true;
    package = pkgs-unstable.jujutsu;
    settings = {
      user = {
        email = "luna.xin@outlook.com";
        name = "Luna Xin";
      };
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      shell = "fish";
      enable_audio_bell = false;
    };
    font.size = 12;
    font.name = "JetBrainsMono Nerd Font";
    shellIntegration.enableFishIntegration = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscodium;
    profiles.default.extensions = (
      with pkgs.nix-vscode-extensions.open-vsx;
      [
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        mkhl.direnv
      ]
    );
    profiles.default.enableExtensionUpdateCheck = false;
    profiles.default.enableUpdateCheck = false;
    profiles.default.userSettings = {
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;
      "editor.formatOnSave" = true;
      "editor.minimap.enabled" = false;
      "nix.enableLanguageServer" = true;
      "terminal.integrated.defaultProfile.linux" = "fish";
      "nix" = {
        "serverPath" = "nixd";
        "serverSettings" = {
          "nixpkgs" = {
            "expr" = "import (builtins.getFlake \"/home/luna/dotfiles/nixos\").inputs.nixpkgs { }   ";
          }; # todo: change hardcoded tsuki to get it from nix instead
          "nixd" = {
            "formatting"."command" = [ "nixfmt" ];
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"/home/luna/dotfiles/nixos\").nixosConfigurations.tsuki.options";
              };
              "home-manager" = {
                "expr" =
                  "(builtins.getFlake \"/home/luna/nixos-config\").nixosConfigurations.tsuki.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
      };
    };
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      font = {
        size = 12;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.fish = {
    enable = true;
    package = pkgs-unstable.fish; # newer version of fish supports dynamic loading for jj completions
  };

  programs.nix-index = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  programs.yazi = {
    enable = true;
    package = pkgs-unstable.yazi; # need unstable for theming to work
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  nixGL.vulkan.enable = true;

  # OPTION B: Use the Home Manager module (Recommended)
  programs.zed-editor = {
    enable = true;

    # Override the default Nixpkgs version with the latest from the flake
    package = inputs.zed.packages.${pkgs.system}.default;

    # Declaratively manage extensions
    extensions = [
      "nix"
      "toml"
      "rust"
    ];

    # Declaratively manage your settings.json
    userSettings = {
      vim_mode = true;
      theme = {
        mode = "system";
        dark = "One Dark";
      };
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
