import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationData;

  LocationScreen({@required this.locationData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String locationName;
  String weatherIconString;
  String weatherMessage;
  WeatherModel wModel = WeatherModel();

  String requestedCityName;

  @override
  void initState() {
    super.initState();
    // widget proper of this class gives access oth the StatefulWidget parent
    // that's how can access the locationDate.
    updateUI(widget.locationData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        // for any many reason this can happen
        temperature = 0;
        locationName = '';
        weatherIconString = 'Error';
        weatherMessage = 'Unable to get weather data';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      locationName = weatherData['name'];
      int weatherId = weatherData['weather'][0]['id'];
      weatherIconString = wModel.getWeatherIcon(weatherId);
      weatherMessage = wModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/haunted.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await wModel.getWeatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      requestedCityName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));

                      if (requestedCityName != null) {
                        // request weather for this city
                        var weatherData =
                            await wModel.getCityData(requestedCityName);
                        updateUI(weatherData);

                        // update the ui
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°F',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIconString',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $locationName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
