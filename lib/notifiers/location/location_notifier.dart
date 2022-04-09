import 'package:example_weather_app/notifiers/location/location_exceptions_enum.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

export 'location_exceptions_enum.dart';

class LocationNotifier extends ChangeNotifier {
  LocationNotifier();

  LocationData? state;

  Future<LocationExceptionsEnum> updateLocation() async {
    final location = Location.instance;

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        debugPrint('Location service is disabled!');
        return LocationExceptionsEnum.serviceDisabled;
      }
    }

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted ||
          _permissionGranted != PermissionStatus.grantedLimited) {
        debugPrint('Location service is unavailable!');
        return LocationExceptionsEnum.permissionDenied;
      }
    }

    state = await location.getLocation();
    notifyListeners();
    return LocationExceptionsEnum.none;
  }
}
