# home/git.nix — version control configuration driven by vars.
{ pkgs-unstable, vars, ... }:
{
  # ------------------------------------------------------------------ #
  # Git
  # ------------------------------------------------------------------ #
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = vars.git.name;
        email = vars.git.email;
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  # ------------------------------------------------------------------ #
  # Jujutsu — a Git-compatible VCS with a cleaner mental model.
  # Use the unstable package for dynamic completion support.
  # ------------------------------------------------------------------ #
  programs.jujutsu = {
    enable = true;
    package = pkgs-unstable.jujutsu;
    settings = {
      user = {
        name = vars.git.name;
        email = vars.git.email;
      };
    };
  };
}
