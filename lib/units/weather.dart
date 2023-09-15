import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';

const apikey = "6d688c498c96fd5cbacc8c55842d9fb0";

class WeatherDisplayData {
  final Icon weatherIcon;
  final AssetImage backgroundImage;

  WeatherDisplayData({required this.weatherIcon, required this.backgroundImage});
}


class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  late double currentTemperature;
  late int currentCondition;
  late String currentCity;

  Future<void> getCurrentTemperature() async {
    Uri uri = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apikey}&units=metric");
    Response response = await get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        currentCity = currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API'dan veri alınamadı");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      // Hava buludludursa
      return WeatherDisplayData(
        weatherIcon: Icon(
          FontAwesomeIcons.cloud,
          size: 75,
          color: Colors.white,
        ),
        backgroundImage: AssetImage('photos/yagisli.jpg'),
      );
    } else {
      var now = DateTime.now();
      if (now.hour >= 19 || now.hour < 6) {
        // Gecedirse 
        return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.moon,
            size: 75,
            color: Colors.white,
          ),
          backgroundImage: AssetImage('photos/gece.jpeg'),
        );
      } else {
        // Diger veziyyetlerde
        return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.sun,
            size: 75,
            color: Colors.yellow,
          ),
          backgroundImage: AssetImage('photos/gunes.jpeg'),
        );
      }
    }
  }
}
