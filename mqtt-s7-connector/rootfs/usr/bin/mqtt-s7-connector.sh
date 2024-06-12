#!/bin/sh

# -------------------------------------------------------------
# This file is in etc/s6-overlay/s6-rc.d/mqtt-s7-connector/run
# -------------------------------------------------------------

# set log level >> 0: Trace, 1: Debug, 2: Info, 3: Notice, 4: Warning, 5: Error, 6: Fatal'
if bashio::config.has_value 'log_level'; then
  case bashio::config 'loglevel' in
    'trace')
      loglevel = '0'
      ;;
    'debug')
      loglevel = '1'
      ;;
    'info')
      loglevel = '2'
      ;;
    'notice')
      loglevel = '3'
      ;;
    'warning')
      loglevel = '4'
      ;;
    'error')
      loglevel = '5'
      ;;
    'fatal')
      loglevel = '6'
      ;;
  esac
else
  loglevel = '4'
fi

# check if there is more then 1 connection is needed
if bashio::config.has_value 'config_files'; then # 'config_files' indicates there are more than 1 config files
  command = ''
  first = true
  for config_file in $(bashio::config 'config_files'); do
    if first ; do
      command += 'npm --prefix /usr/src/mqtt-s7-connector start -- --yaml --config "/config/'
      command += $config_file
      command += '" --loglevel='
      command += $loglevel
    else
      command += '& npm --prefix /usr/src/mqtt-s7-connector start -- --yaml --config "/config/'
      command += $config_file
      command += '" --loglevel='
      command += $loglevel
    fi
    first = false
  done
else
  if bashio::config.has_value 'config_file'; then # 'config_file' indicates there is only 1 config file
    config_file = ${bashio::config 'config_file'}
    command = 'npm --prefix /usr/src/mqtt-s7-connector start -- --yaml --config "/config/'
    command += $config_file
    command += '" --loglevel='
    command += $loglevel
  else # if none of the options if given, launch the default "config.json"
    command = 'npm --prefix /usr/src/mqtt-s7-connector start -- --config "/config/config.json" --loglevel='
    command += $loglevel
  fi
fi

eval $command

# If the exit code is uncought, pass the second exit code received.
if test "$1" -eq 256 ; then
  e=$((128 + $2))
else
  e="$1"
fi

# Pass the exit code to S6 Overlay so we can know the exit code later.
echo "exit code: $e"