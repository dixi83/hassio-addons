# MQTT S7 Connector - Home Assistant Addon

_MQTT Siemens S7 connector to integrate Siemens PLC's with Home Assistant_

This project integrates [mqtt-s7connector developed by Tim Roemisch](https://github.com/timroemisch/mqtt-s7-connector) as an add-on for Home Assistant.

<!-- Because the folder structure is had to be completely changed, I was not able anymore to keep the original repo in sync. I will try to fix this with scripting later on. -->

The [documentation](./DOCS.md) file is edited so it will contain everything you need to know to make it work with your Home Assistant installation and your Siemens PLC.

## Credits

- [plcpeople / nodeS7](https://github.com/plcpeople/nodeS7)
- [mqttjs / MQTT.js](https://github.com/mqttjs/MQTT.js)
- [Home Assistant Community Addons](https://github.com/hassio-addons/)
- [mqtt-s7connector](https://github.com/timroemisch/mqtt-s7-connector) developed by Tim Roemisch

Special thanks to Franck Nijhof aka [Frenck](https://github.com/frenck) for all the work he does for the Home Assistant Community. If you read this please consider sponsoring him.

## TODO

- config file and documentation json > yaml (easier and less chance of failures)
- add multi PLC connection support
- test and document support for Siemens LOGO! (it should work)[https://github.com/plcpeople/nodeS7/issues/37]
- add more Home Assistant [entities](https://developers.home-assistant.io/docs/core/entity)
- code cleanup

Pull requests welcome!
