#!/command/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Home Assistant Add-on: ModBus Measurement Daemon
# Runs the ha-mbmd
# ==============================================================================
declare command

command="/usr/local/bin/mbmd run"

eval "$command"

# If the exit code is uncought, pass the second exit code received.
if test "$1" -eq 256 ; then
  e=$((128 + $2))
else
  e="$1"
fi

# Pass the exit code to S6 Overlay so we can know the exit code later.
echo "exit code: $e"