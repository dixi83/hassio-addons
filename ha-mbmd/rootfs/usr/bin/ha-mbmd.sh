#!/command/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Home Assistant Add-on: ModBus Measurement Daemon
# Runs the ha-mbmd
# ==============================================================================
declare command
declare loglevel
declare log_level
declare first

log_level=$(bashio::string.lower "$(bashio::config log_level invalid)")

if [ "$log_level" = "invalid" ]; then
  bashio::log.magenta 'Received invalid log_level from config, fallback to warning'
  log_level="warning"
  loglevel=4
fi

# set log level >> 0: Trace, 1: Debug, 2: Info, 3: Notice, 4: Warning, 5: Error, 6: Fatal'
case "$log_level" in
  "trace")
    loglevel="0"
    ;;
  "debug")
    loglevel="1"
    ;;
  "info")
    loglevel="2"
    ;;
  "notice")
    loglevel="3"
    ;;
  "warning")
    loglevel="4"
    ;;
  "error")
    loglevel="5"
    ;;
  "fatal")
    loglevel="6"
    ;;
  *)
    loglevel="4"
    bashio::log.red 'Unknown log level has been set, took 4 to continue the startup'
    ;;
esac

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