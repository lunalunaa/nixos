# modules/nixos/services.nix — system services, daemons, and globally-installed programs.
{ pkgs, ... }:
{
  # ------------------------------------------------------------------ #
  # Globally-available CLI tools
  # ------------------------------------------------------------------ #
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    # Nix language server — used by editors at evaluation time before
    # Home Manager activates, so it lives at the system level too.
    nil
    helix
  ];

  # ------------------------------------------------------------------ #
  # System programs
  # ------------------------------------------------------------------ #

  # Install Firefox system-wide so it is available before HM activates.
  programs.firefox.enable = true;

  # GnuPG agent — enables gpg-agent for signing commits, SSH auth, etc.
  programs.gnupg.agent.enable = true;

  # nix-ld: provides a dynamic linker shim so pre-built ELF binaries
  # (e.g. downloaded scripts, VSCode extensions) run without patching.
  programs.nix-ld.enable = true;

  # ZSH is installed at the system level so it exists as a login shell
  # before Home Manager activates (used in users.nix for bootstrapping).
  programs.zsh.enable = true;

  # ------------------------------------------------------------------ #
  # Network / remote access
  # ------------------------------------------------------------------ #

  # OpenSSH daemon — allows incoming SSH connections.
  services.openssh = {
    enable = true;
    settings = {
      # Disable password login; rely on key-based auth only.
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # ------------------------------------------------------------------ #
  # Printing
  # ------------------------------------------------------------------ #
  services.printing.enable = true;
}
