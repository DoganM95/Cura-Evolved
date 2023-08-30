#!/bin/sh

# Start Openbox
openbox &

# Run obxprop after a delay (let's say 10 seconds to allow the window to open)
(
  sleep 10
  obxprop > /tmp/obxprop_output.txt
) &

# Execute the AppRun from the extracted AppImage directory
/app/squashfs-root/AppRun