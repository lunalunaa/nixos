# home/shell.nix — shell programs, terminal emulators, and CLI utilities.
{ pkgs-unstable, ... }:
{
  # ------------------------------------------------------------------ #
  # Shells
  # ------------------------------------------------------------------ #

  programs.fish = {
    enable = true;
    # Use unstable — it supports dynamic completion loading,
    # which is required for jj to register its completions at runtime.
    package = pkgs-unstable.fish;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # ------------------------------------------------------------------ #
  # Prompt
  # ------------------------------------------------------------------ #

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      line_break.disabled = true;
      aws.disabled = true;
      gcloud.disabled = true;
    };
  };

  # ------------------------------------------------------------------ #
  # Terminal emulators
  # ------------------------------------------------------------------ #

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      shell = "fish";
      enable_audio_bell = false;
    };
    shellIntegration.enableFishIntegration = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 12;
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  # ------------------------------------------------------------------ #
  # CLI utilities
  # ------------------------------------------------------------------ #

  # eza — a modern `ls` replacement with colour, icons, and git status.
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  # yazi — terminal file manager.  Use unstable for theme support.
  programs.yazi = {
    enable = true;
    package = pkgs-unstable.yazi;
  };
}
