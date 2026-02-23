# modules/nixos/sound.nix — PipeWire audio stack with PulseAudio compatibility.
{ ... }:
{
  # Disable PulseAudio — PipeWire provides a drop-in replacement.
  services.pulseaudio.enable = false;

  # RTKit allows PipeWire to acquire realtime scheduling priority.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    # Expose a PulseAudio-compatible socket so legacy apps work unchanged.
    pulse.enable = true;
  };
}
