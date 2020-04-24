import '../services/location.dart';
import '../utilities/constants.dart';
import 'networking.dart';
import 'location.dart';

class WeatherModel {
  Future<dynamic> getCityData(String city) async {
    Location currLocation = Location();
    await currLocation
        .getCurrentLocation(); // will not proceed until this is completed
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={your api key}
    String urlString =
        '$kOpenWeatherApiUrl?q=$city&units=imperial&appid=$kWeatherApiKey';

    NetworkHelper helper = NetworkHelper(urlString);
    var jsonDecodedData =
        await helper.getData(); // dont proceed until you get the data
    // print(jsonDecodedData);

    return jsonDecodedData;
  }

  Future<dynamic> getWeatherData() async {
    Location currLocation = Location();
    await currLocation
        .getCurrentLocation(); // will not proceed until this is completed

    String urlString =
        '$kOpenWeatherApiUrl?lon=${currLocation.longitude}&lat=${currLocation.latitude}&units=imperial&appid=$kWeatherApiKey';
    NetworkHelper helper = NetworkHelper(urlString);
    var jsonDecodedData =
        await helper.getData(); // dont proceed until you get the data

    return jsonDecodedData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int tempFarenheit) {
    if (tempFarenheit > 75) {
      return 'It\'s 🍦 time';
    } else if (tempFarenheit > 65) {
      return 'Time for shorts and 👕';
    } else if (tempFarenheit < 45) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
