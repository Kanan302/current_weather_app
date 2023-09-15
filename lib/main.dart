import 'package:flutter/material.dart';
import 'package:weather_app/screens/loading_screen.dart';
// import 'package:weather_app/screens/main_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}

//40.37936 latitude
//49.8128617 longitude

// https://api.openweathermap.org/data/2.5/weather?lat=40.37936&lon=49.8128617&appid=6d688c498c96fd5cbacc8c55842d9fb0&units=metric