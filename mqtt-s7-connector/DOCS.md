# MQTT S7 Connector - Home Assistant Addon

This project integrates [mqtt-s7connector developed by Tim Roemisch](https://github.com/timroemisch/mqtt-s7-connector) as an add-on for Home Assistant.

<!-- Because the folder structure is had to be completely changed, I was not able anymore to keep the original repo in sync. I will try to fix this with scripting later on. -->

This documentation file is edited so it will contain everything you need to know to make it work with your Home Assistant installation and your Siemens PLC.

## Purpose

This tool can receive data over mqtt and can write it to a designated address on a plc and vice versa, enabling smart home data to be displayed in the Home Assistant.

## Requirements:

- Home Assistant installation (HAOS or Supervised, other installation methods do not support addons)
- a [MQTT broker](https://github.com/home-assistant/addons/tree/master/mosquitto)
- the Home Assistant [MQTT integration](https://www.home-assistant.io/integrations/mqtt/)
- Siemens PLC (S7-300,400,1200 or 1500) with an ethernet connection. I will add support for LOGO
- Access to the PLC program/software

## How to install

- Open your Home Assistant web interface
- Go to Settings > Add-ons
- In the lower right corner click "Add-on Store"
- At the top right, click the 3 dots and "Repositories"
- Now add `https://github.com/dixi83/hassio-addons` and click "Add" followed by "Close"
- Find the "MQTT Siemens S7 Connector" in the store and click "Install"

Or add the repo by clicking:

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fdixi83%2Fhassio-addons)

## Addon configuration
### 1 PLC
If you just need to connect to 1 PLC, use this configuration:
```yaml
  log_level: info
  config_file: config.yaml
```

### Multiple PLC's
If you have multiple PLC's use this as an example:
```yaml
  log_level: info
  config_files: 
    - config_plc1.yaml
    - config_plc2.yaml
```

## Config File(s)

After installing the Addon a created the `addon_configs\xxxxxxxx_mqtt-s7-connector` folder. Inside this folder you'll find the [`config.example.yaml`](./rootfs/usr/src/app/config.example.yaml) file. This file contains an example of the configuration. Copy the file and rename it to `config.json` as a starting point

There are several ways to get access to this folder and files, e.g.:

- Samba share add-on
- File editor add-on
- Visual Studio server add-on

For the documentation of the config files please refer to this: 
[YAML](CONFIG_YAML.md)
[JSON](CONFIG_JSON.md)

## Auto Discovery

This tool will send for each device an auto-discovery message over mqtt in the correct format defined by Home Assistant.

The default mqtt topic is `homeassistant`, it can be changed in the config file. (See the [example](config.example.json#L10))

## License

[Licensed under ISC](LICENSE)  
Copyright (c) 2021 Tim Römisch
