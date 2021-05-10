import 'package:flutter/material.dart';
import 'package:newweatherapp/screens/city_screen.dart';
import 'package:newweatherapp/utilities/constants.dart';
import 'package:newweatherapp/services/weather.dart';
import 'package:newweatherapp/screens/home.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  dynamic temperature;
  int temp;
  String cityname;
  String weatherIcon;
  String weatherMsg;
  String weathertype;
  dynamic humidity;
  dynamic windspeed;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationweather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 00;
        weatherIcon = '⚠️';
        weatherMsg = 'Unable to get your weather!';
        cityname = '';
        return;
      } else {
        temperature = weatherData['main']['temp'];
        temp = temperature.toInt();
        // temp = temperature.toInt();

        // if (temperature is double) {
        //   temperature = temp.toInt();
        // } else {
        //   temperature;
        // }
        cityname = weatherData['name'];
        weathertype = weatherData['weather'][0]['main'];
        humidity = weatherData['main']['humidity'];
        windspeed = weatherData['wind']['speed'];

        var condition = weatherData['weather'][0]['id'];
        // print(condition);
        weatherIcon = weatherModel.getWeatherIcon(condition);
        weatherMsg = weatherModel.getMessage(temperature.toInt());

        // if (temperature is double) {
        //   return temperature.toInt();
        // } else {
        //   return temperature;
        // }
      }
    });

    // print(temperature);
    // print(cityname);
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var wdata = await weatherModel.getLocationWeather();
                        updateUI(wdata);
                      },
                      child: Icon(
                        Icons.location_on,
                        size: 50.0,
                        color: Colors.yellow,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Home();
                        }));
                      },
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        size: 50.0,
                        color: Colors.yellow,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typeName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        // print(typeName);
                        if (typeName != null) {
                          var weatherData =
                              await weatherModel.getLocationCity(typeName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.search_off_outlined,
                        size: 50.0,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 40.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temp°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        ' $weatherIcon',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25.0, bottom: 80.0),
                  child: Text(
                    'Condition - $weathertype \n Humidity - $humidity % \n Wind Speed - $windspeed km/h',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Spartan MB'),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    "$weatherMsg in $cityname!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// print(temperature);
// print(cityname);
// print(condition);
