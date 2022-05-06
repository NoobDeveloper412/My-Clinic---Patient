import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/cityModel.dart';
import 'package:http/http.dart' as http;

class CityService {
  static const _viewUrl = "$apiUrl/get_city";

  static List<CityModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<CityModel>.from(
        data.map((item) => CityModel.fromJson(item)));
  }

  static Future<List<CityModel>> getData() async {
    final response = await http.get(Uri.parse("$_viewUrl"));
    if (response.statusCode == 200) {
      List<CityModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
