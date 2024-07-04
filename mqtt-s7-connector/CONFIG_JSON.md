# Config file in JSON format

Because mqtt-s7-connector module was originally designed to work with a JSON configuration. I Don't want to break
the original functionality I decided to leave the json handling as it was. If you want to use YAML please refer [this](CONFIG_YAML.md)
document.

## Config File

The configuration file has to be located in the same directory as the installation and has to be named `config.json`

**An example of a correct configuration file is found in [`config.example.json`](https://github.com/timroemisch/mqtt-s7-connector/blob/master/config.example.json).**

The **json** config file has to be valid JSON (You can check [here](https://jsonformatter.curiousconcept.com/) if it´s correct)  
and is separated in 3 sections:

json:

- [`"plc":`](#plc-object)
- [`"mqtt":`](#mqtt-object)
- [`"devices":`](#devices-object)

### `plc:` Object

\_general setup of the connection to the plc\_\_

In the most use cases you only have to change the host value to the correct ip

```json lines
"plc": {
    "port": 102,
    "host": "192.168.0.1",
    "rack": 0,
    "slot": 2,
    "debug": false
}
```

### `mqtt` Object

_general setup of the connection to the mqtt broker_

The URL/host value can be one of the following protocols: 'mqtt', 'mqtts', 'tcp', 'tls', 'ws', 'wss'.

If you are using a self-signed certificate, use the `rejectUnauthorized: false` option. Beware that you are exposing yourself to man in the middle attacks, so it is a configuration that is not recommended for production environments.
[More info](https://github.com/mqttjs/MQTT.js#mqttconnecturl-options)

```json lines
"mqtt": {
    "host": "mqtts://host.com:1234",
    "user": "u",
    "password": "p",
    "rejectUnauthorized": true
}
```

### `devices:` Object

_list of all registered devices_

the list of devices is implemented as an array in json.  
each device has it's own entry in this list and will be configured there.

Each device has to have a 'name' entry and a 'type' entry, the remaining attributes are optional

```json lines
"devices": [
      {
          "name": "Dimmable Light",
          "type": "light",

          "state": "DB56,X150.0",
          "brightness": "DB56,BYTE151"
      },
      {
          "name": "Dimmable Light 2",
          "type": "light",

          "state": "DB56,X150.1",
      }
]
```

## Address formatting

This tool uses the NodeS7 Library and it uses the same address formatting.  
An example of correct formatted addresses is found at the [NodeS7 Repository](https://github.com/plcpeople/nodeS7#examples)

**Address examples:**  
DB56,X150.0 _(read from DB56 one bit at 150.0)_  
DB51,REAL216 _(read from DB51 four bytes starting from byte 216)_  
DB56,BYTE40 _(read from DB56 one byte at 40)_

**Supported data types**  
X = 1 Bit -> converted to true / false  
BYTE = 1 Byte (8 Bit) -> converted to Int  
REAL = 4 Bytes (32 Bit) -> converted to Float

For more information see the [NodeS7 Repository](https://github.com/plcpeople/nodeS7#examples)

## Device types and attributes

The device type categories are based on the categories from Home Assistant  
**It is strongly recommended to look into the [example configuration file](https://github.com/timroemisch/mqtt-s7-connector/blob/master/config.example.json) !!**

Current list of supported device types with supported attributes:

- light

  - `state` _(X)_  
    on/off state of the device

  - `brightness` _(BYTE)_  
    value between 0-255

- sensor

  - `state` _(X/BYTE/REAL)_  
    state of device  
    _is readonly by default_

- switch

  - `state` _(X)_  
    on/off state of the device

- climate

  - `target_temperature` _(REAL)_

  - `current_temperature` _(REAL)_  
    _readonly by default_  
    _update_interval is 15 min by default_

- cover

  - `targetPosition` _(BYTE)_

  - `tiltAngle` _(BYTE)_

  - `currentPosition` _(BYTE)_  
    _readonly by default_

  - `currentTiltAngle` _(BYTE)_  
    _readonly by default_

  - `trigger` _(X)_  
    **internal value**: it won't be exposed over mqtt  
    this bit will be turned on and off automatically after one of the other attributes of the cover will be changed

- binaryCover

  - `targetPosition` _(X)_

  - `currentPosition` _(X)_  
    _readonly by default_

## Attribute Options

A "simple" device has just the plc address as the value of the attributes,  
however it's possible to configure each attribute individually by assigning an object instead of a string to it.

Simple Attribute:

```json lines
"state": "DB56,X150.0",
```

Rewritten Attribute:

```json lines
"state": {
  "plc": "DB56,X150.0"
},
```

Now after rewriting it's possible to add more options inside the brackets of the attribute.

**Available options:**

### `rw` option

> Changes the read / write permissions

|     | Read PLC | Write PLC | Subscribe MQTT | Publish MQTT |
| --- | -------- | --------- | -------------- | ------------ |
| r   | ✅       | ❌        | ❌             | ✅           |
| w   | ❌       | ✅        | ✅             | ❌           |
| rw  | ✅       | ✅        | ✅             | ✅           |

```json lines
"state": {
    "plc": "DB56,X150.0",
    "rw": "r"
},
```

### `update_interval` option

By default, (without this option) each attribute will send an update over mqtt after it changes, but this option will disable it and set an interval for updates.  
The time is set in ms

```json lines
"state": {
    "plc": "DB56,BYTE234",
    "update_interval": 1000
},
```

### `unit_of_measurement` option

This is only for Home Assistant. It will add a additional unit of measurement to the data.

```json lines
"state": {
    "plc": "DB56,REAL10",
    "unit_of_measurement": "km/h"
},
```

### `set_plc` option

By default attributes have only one address, but if you define "set_plc"  
the attribute will read from "plc" and write to "set_plc"

```json lines
"state": {
    "plc": "DB56,X150.0",
    "set_plc": "DB56,X150.1"
},
```

### `write_back` option

When using both `plc_address` and `plc_set_address`, setting `write_back` to `true`
will automatically write any changes read from `plc_address` to `plc_set_address`.

```json lines
"state": {
    "plc": "DB56,X150.0",
    "set_plc": "DB56,X150.1",
    "write_back": true
},
```
