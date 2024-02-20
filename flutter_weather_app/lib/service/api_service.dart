import 'dart:convert';

import 'package:flutter_weather_app/constants/constants.dart';
import 'package:http/http.dart';

import '../model/weather_model.dart';

class ApiService {
  Future<WeatherModel> getWeatherData(String searchText) async {
    String url = "$base_url&q=$searchText&days=7";

    try {
      Response response = await get(
        Uri.parse(url),
      );
      if(response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      }else {
        throw("No Data Found");
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
