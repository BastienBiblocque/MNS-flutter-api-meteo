import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiNinjaService {
  static const String url = 'https://api.api-ninjas.com/v1/';
  final dio = Dio();

  ApiNinjaService() {
    dio.options.headers["X-Api-Key"] = dotenv.get('NINJA_API_KEY');
  }

  Future getCityInformation(String city) async {
    final response = await dio.get('${url}city?name=$city');
    return response.data;
  }
}
