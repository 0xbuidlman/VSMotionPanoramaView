## Introduction
Because Google Maps (<a href="https://developers.google.com/maps/documentation/ios/reference/interface_g_m_s_panorama_view">GMSPanoramaView</a>) does not have support for motion device, we decided to implement VSMotionPanoramaView.

VSMotionPanoramaView inherits from Panorama View to add motion device support. 

This enables you to show Google Street View map images using the device motion without touching the screen.

## How to use it on your project
* Copy the VSMotionPanoramaView folder to your project.
* Just use VSMotionPanoramaView instead of GMSPanoramaView, by default the property orientationMotion will be enabled (and orientationGestures will be disabled to avoid conflict).

## Example project
* Clone this repository.
* Execute pod install (to download <a href="https://developers.google.com/maps/documentation/ios/start">GoogleMaps SDK</a>).
* Configure your <a href="https://developers.google.com/maps/documentation/ios/start#step_5_get_an_ios_api_key">Google Maps Api Key</a> in AppDelegate.m.
* Run it on your device.

