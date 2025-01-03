**Please note:**
Soon the update will contain the preparations and for the object rename form `devices` to `enities`.

## 1.0.8

- fix(sensor): Missing unit_of_measurement in ha-discovery payload ( @psi-4ward )
- feat(sensor): Support more ha-discovery options ( @psi-4ward )
- fix: Value gets not published if it is 0 ( @psi-4ward )
- feat(device): Add support for "manufacturer" in device section ( @psi-4ward )
- feat(device): Generate more unique mqttNames when name and device_nam… ( @psi-4ward )
- feat(config): Add example how to configure a device with sensors ( @psi-4ward )

## 1.0.7

- Added `number` device

## 1.0.6

- updated git package from 2.43.4-r0 to 2.43.5-r0

## 1.0.5

- Updated start script, which I was forgotten...

## 1.0.4

- skipped some test versions
- updated javascript application to you can define devices now be combined in a MQTT device by setting the `device_name` property.
- origin info is now written to the dicovery topic.

## 1.0.1

- fixed `eval: line 71: unexpected EOF while looking for matching '"'`

## 1.0.0

- First release
