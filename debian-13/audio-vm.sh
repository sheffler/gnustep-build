#!/bin/bash
#
# Fix the audio in a Debian VM running on OSX Apple Silicon
#

#
# Make larger bufferrs in pipewire
# PipeWire quantum: Increased from 1024 to 4096, reducing how often it needs precise timing
#

mkdir -p ~/.config/pipewire/pipewire.conf.d/
cat > ~/.config/pipewire/pipewire.conf.d/99-vm-tweaks.conf <<EOF
context.properties = {
    default.clock.rate = 48000
    default.clock.quantum = 8192
    default.clock.min-quantum = 8192
    default.clock.max-quantum = 16384
    default.clock.force-quantum = 8192
}

stream.properties = {
    resample.quality = 1
    channelmix.normalize = false
    audio.format = "S16LE"
    audio.rate = 48000
    node.latency = "8192/48000"
}EOF

#
# ALSA dmix: Handles mixing at a lower level with bigger buffers (8192 samples)
#

cat > ~/.asoundrc <<EOF
defaults.pcm.!card 0
defaults.ctl.!card 0

pcm.!default {
    type plug
    slave.pcm {
        type dmix
        ipc_key 1024
        slave {
            pcm "hw:0,0"
            period_time 0
            period_size 4096
            buffer_size 16384
            rate 48000
        }
    }
}
EOF

#
# System Bell
#

# cat > ~/.config/pipewire/pipewire.conf.d/ <<EOF
# pulse.cmd = [
#     { cmd = "load-module" args = "module-x11-bell sample=bell-window-system" flags = [ ] }
# ]
# EOF


#
# Restart Pipewire
#

systemctl --user restart pipewire pipewire-pulse wireplumber

#
# Verify it is working
#

pactl info
aplay /usr/share/sounds/alsa/Front_Left.wav
echo -e '\a'
