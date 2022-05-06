import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/availabilityModel.dart';
import 'package:http/http.dart' as http;

class AvailabilityService {
  static const _viewUrl = "$apiUrl/get_availability";

  static List<AvailabilityModel> availabilityFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<AvailabilityModel>.from(
        data.map((item) => AvailabilityModel.fromJson(item)));
  }

  static Future<List<AvailabilityModel>> getAvailability() async {
    final response = await http.get(Uri.parse(_viewUrl));
    if (response.statusCode == 200) {
      List<AvailabilityModel> list = availabilityFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
