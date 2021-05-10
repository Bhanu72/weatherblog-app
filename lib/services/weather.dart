import 'package:newweatherapp/services/location.dart';
import 'package:newweatherapp/services/networking.dart';

const apiKey = '5721822e5320121bf566067ec8510940';

class WeatherModel {
  Future<dynamic> getLocationCity(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    double latitude = location.latitude;
    double longitude = location.longitude;

    print(latitude);
    print(longitude);

    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=6.9319&lon=79.8478&appid=$apiKey&units=metric');
    //lat":6.9319,"lon":79.8478

    var weatherData = await networkHelper.getData();

    return weatherData;
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

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Yo! It\'s Hot Out Here!!! 🥵';
    } else if (temp > 20) {
      return 'Yo! Best Climate Here! 😎';
    } else if (temp < 10) {
      return 'Cool! Cool! Cool! 🥶';
    } else {
      return 'Don\'t Forget Your Jacket 🧥';
    }
  }
}
