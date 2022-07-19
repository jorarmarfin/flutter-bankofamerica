import 'package:flutter/material.dart';
import 'package:location/location.dart';

class GeolocationProvider extends ChangeNotifier {
  var location = Location();
  late LocationData currentPosition;
  GeolocationProvider() {
    getLocation();
  }

  Future getLocation() async {
    // late LocationData currentPosition;
    bool enableLocation = await location.serviceEnabled();
    PermissionStatus permissionGranted;
    if (!enableLocation) {
      enableLocation = await location.requestService();
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentPosition = await location.getLocation();

    return currentPosition;
  }
}
