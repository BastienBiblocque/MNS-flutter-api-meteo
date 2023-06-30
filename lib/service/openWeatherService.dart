import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenWeatherService {
  static const String url = 'https://api.openweathermap.org/data/2.5/';
  final dio = Dio();

  getWeatherData(double lat, double long) async {
    final response = await dio.get(
        '${url}weather?lat=$lat&lon=$long&appid=${dotenv.get('OPEN_WEATHER_API_KEY')}&units=metric');
    return response.data;
  }
}
