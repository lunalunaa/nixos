# hosts/default.nix — add a new attribute here for each machine you manage.
{ inputs }:
{
  tsuki = import ./tsuki { inherit inputs; };
}
