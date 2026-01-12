import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherService {
  // Corrected variable name from opiKey to apiKey for consistency.

  static const String apiKey = '52e62e31ae63b129f45f93f0197768ac';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  // The getWeather method has been moved inside the WeatherService class.
  static Future<Weather> getWeather(String cityName) async {
    try {
      // step 1 : Construct the complete api url
      // Corrected variable names to match their declarations (cityName, apiKey).
      final String url = '$baseUrl?q=$cityName&appid=$apiKey&units=metric';

      // step 2 : make http get request
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      // step 3: check https status
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Weather.fromJson(data);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API Key. Please check your apiKey in weather_service.dart.');
      } else if (response.statusCode == 404) {
        throw Exception('City not found, pls check the spelling');
      } else {
        // Corrected typo "Faioled" to "Failed".
        throw Exception('Failed to load Weather, status: ${response.statusCode}');
      }
    } catch (e) {
      // This catch block will handle network errors or any other unexpected exceptions.
      throw Exception('Error fetching weather: $e');
    }
  }
}
