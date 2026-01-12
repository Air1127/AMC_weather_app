class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    try {
      return Weather(
        cityName: json['name'] as String? ?? 'Unknown City',
        temperature: (json['main']?['temp'] as num? ?? 0.0).toDouble(),
        mainCondition: json['weather']?[0]?['main'] as String? ?? 'Unknown',
        humidity: (json['main']?['humidity'] as num? ?? 0).toInt(),
        windSpeed: (json['wind']?['speed'] as num? ?? 0.0).toDouble(),
      );
    } catch (e) {
      // Provide a more detailed error if JSON parsing fails.
      throw Exception('Error parsing weather data: $e');
    }
  }
}
