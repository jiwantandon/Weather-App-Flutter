import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService
{
    static const BASE_URL = "http://api.openweathermap.org/data/2.5/weather";
    final String apiKey;

    WeatherService(this.apiKey);

    Future<Weather> getWeather(String cityName) async
    {
      final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

      if(response.statusCode == 200)
      {
        return Weather.fromJson(jsonDecode(response.body));
      }
      else
      {
        throw Exception("Failed to Load Data. Try Again!");
      }

    }
    Future<String> getCurrentCity() async
    {
      // Get Permission From User
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied)
      {
        permission = await Geolocator.requestPermission();
      }
      // Fetch The Current Location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      // Convert the location into a list of placemark objects
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      // Extract the city name
      String? city = placemarks[0].locality;
      return city ?? "";
    }


}