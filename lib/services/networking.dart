import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newweatherapp/screens/location_screen.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    // http.Response response = await http.get(Uri.parse(
    //     'http://api.openweathermap.org/data/2.5/find?q=Colombo&appid=$apiKey&units=metric'));
    // print(response.body);
    if (response.statusCode == 200) {
      String newdata = response.body;

      return jsonDecode(newdata);
    } else {
      print(response.statusCode);
    }
  }
}
