# Load driver to direct non video audio out the HDMI such as Radiogaga.
# Use if not using an attached USB audio output device.
(
modprobe snd_bcm2835;
) &

