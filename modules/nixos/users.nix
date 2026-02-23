# modules/nixos/users.nix — primary user account definition.
{ pkgs, vars, ... }:
{
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    # Fish is set as the login shell at the system level so it is available
    # before Home Manager activates.
    shell = pkgs.fish;
  };
}
