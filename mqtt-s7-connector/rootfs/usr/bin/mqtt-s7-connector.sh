#!/bin/sh

# -------------------------------------------------------------
# This file is in etc/s6-overlay/s6-rc.d/mqtt-s7-connector/run
# -------------------------------------------------------------

# Tell the FileApp to unorphan each file processing.
npm --prefix /usr/src/mqtt-s7-connector start -- --config "/config/config.json"

# If the exit code is uncought, pass the second exit code received.
if test "$1" -eq 256 ; then
  e=$((128 + $2))
else
  e="$1"
fi

# Pass the exit code to S6 Overlay so we can know the exit code later.
echo "exit code: $e"