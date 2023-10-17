import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API Key
  final _WeatherService = WeatherService('75770ef28785b4459e65b9639c5f7129');
  Weather? _weather;
  
  // Fetch Weather
  _fetchWeather() async
  {
     // Get the current city
     String cityName = await _WeatherService.getCurrentCity();

     // Get the weather for the city
     try
     {
      final Weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = Weather;
      });
     }
     // Catch Any Errors
     catch(e)
     {
      print(e);
     }
  } 
  
  
  // init State
  @override
  void initState()
  {
    super.initState();
    // Fetch Weather on Startup
    _fetchWeather();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City Name
            
            Text(_weather?.cityName ?? "Loading City..."),
            // Animation
            Lottie.asset('assets/main.json'),
            
            // Temperature
            Text('${_weather?.temperature.round()}`C'),
            
            // Weather Condition
            Text(_weather?.mainCondition ?? " ")
          ],
        ),
      ),
    );
  }
  }