import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class Location {
  double longitude;
  double latitude;

  Location();

  // async and wait are used to run time consuming methods in the background
  // so that they are non blocking
  Future<void> getCurrentLocation() async {
    Position position;

    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;

      // print(position);
    } catch (e) {
      print(e);
    }
  }
}
