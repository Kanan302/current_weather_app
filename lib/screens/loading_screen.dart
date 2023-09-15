import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/units/location.dart';
import 'package:weather_app/units/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  LocationHelper LocationData = LocationHelper();
  Future<void> getLocationData() async{
    LocationData = LocationHelper();
    await LocationData.getCurrentLocation();

    // ignore: unnecessary_null_comparison
    if(LocationData.longitude == null || LocationData.latitude == null){
      print("konum melumatlariniz gelmir");
    }

    else
    print("longitude " + LocationData.longitude.toString());
    print("latitude " + LocationData.latitude.toString());
  }


  Future<void> getWeatherData() async{
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: LocationData);
    await weatherData.getCurrentTemperature();
    
    

    // ignore: unnecessary_null_comparison
    if(weatherData.currentCondition == null || weatherData.currentTemperature == null){
      print("API da data 0 gorsedir");
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return MainScreen(weatherData: weatherData);
    }));

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade600, Colors.grey.shade900]
          )
        ),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 2000),
          ),
        ),
      ),
    );
  }
}