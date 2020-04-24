import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // get called as the class is being initialized
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  // async functions are non-blocking calls
  void getLocationData() async {
    // getWeatherData
    var jsonWeatherData = await WeatherModel().getWeatherData();

    // transition to the next screen once we have the data
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationData: jsonWeatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
