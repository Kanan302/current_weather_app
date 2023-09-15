import 'package:flutter/material.dart';
import 'package:weather_app/units/weather.dart';


class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  MainScreen({required this.weatherData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;

  void updateDisplayInfo(WeatherData weatherData, WeatherDisplayData displayData) {
  setState(() {
    temperature = weatherData.currentTemperature.round();
    backgroundImage = displayData.backgroundImage;
    weatherDisplayIcon = displayData.weatherIcon;
    city = weatherData.currentCity;
  });
}

@override
void initState() {
  super.initState();
  WeatherDisplayData displayData = widget.weatherData.getWeatherDisplayData();
  updateDisplayInfo(widget.weatherData, displayData);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration( 
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ), 
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50,),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(height: 20,),
            Center(
              child: Text(
                "$temperature°C",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  letterSpacing: -5
                ),
              ),
            ),
            Center(
              child: Text(
                "$city",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  letterSpacing: -5
                ),
              )
            )  
          ],
        ),
      ),
    );
  }
}