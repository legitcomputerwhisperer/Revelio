# Revelio

Revelio, named after the revealing spell from Harry Potter, is a customizable fade-in animation tweak which makes your home screen app icons appear after a defined time.

## Features
Available animation triggers include:

- Fade-in from unlock
- Fade-in from home button press
- Fade-in after exiting folders

Animation speed is configurable from 1 second up to 15 seconds for each trigger. Triggers can also be disabled individually via a preference panel in Settings.

## Building
- Revelio is built using [theos](https://github.com/DHowett/theos). Follow the [setup](http://iphonedevwiki.net/index.php/Theos/Setup) guide to install it.

- Run ```make clean package install THEOS_DEVICE_IP=xxx THEOS_DEVICE_PORT=xxx``` to build and install Revelio on your device.

## Dependencies
- [Cydia Substrate](http://iphonedevwiki.net/index.php/Cydia_Substrate) the de facto framework that allows 3rd-party developers to provide run-time patches (“Cydia Substrate extensions”) to system functions

- [preferenceloader](https://github.com/DHowett/preferenceloader) enables inclusion of a Settings panel for user configuration of the tweak

## License

MIT License

# Depiction

Revelio, named after the revealing spell from Harry Potter, is a customizable fade-in animation tweak which makes your home screen app icons appear after a defined time.

This tweak the exact opposite of ["Evanesco"](http://cydia.saurik.com/package/com.cpdigitaldarkroom.evanesco/) ...a tweak from CPDigitalDarkroom which makes your homescreen app icons disappear after a set amount of time.
_______________________________

Available animation triggers include:

- Fade-in from unlock
- Fade-in from home button press
- Fade-in after exiting folders

Animation speeds are configurable from 1 to 15 seconds for each trigger. Triggers can also be disabled individually. Touch interactions are not disabled during animation, which can be helpful in urgent situations.
_______________________________

Revelio is compatible with all iOS devices running iOS 10.x through 10.2.1. Tested on the following versions: iOS 10.1.1 & 10.2

All options are enabled by default, so please visit the Settings app to configure if desired. Respring required after installation...but not usually necessary when changing settings. Respring button provided in Settings for convenience.
_______________________________

Please contact me if you have any questions or need any additional information or support!

## Beta Release 1.0.0
- Initial public beta release
