#!/bin/sh

# Start openbox
openbox &

# Run obxprop after a delay
(
  sleep 10
#   obxprop > /tmp/obxprop_output.txt # Debugging step, to get an window's properties with crosshair
) &

# Execute the AppRun from the extracted AppImage directory
/app/squashfs-root/AppRun