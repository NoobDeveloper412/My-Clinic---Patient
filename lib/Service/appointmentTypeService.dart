import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/appointmentTypeModel.dart';
import 'package:http/http.dart' as http;

class AppointmentTypeService {
  static const _viewUrl = "$apiUrl/get_appointmentType";
  static const _viewUrlDId = "$apiUrl/get_apTypeByDid";

  static List<AppointmentTypeModel> availabilityFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<AppointmentTypeModel>.from(
        data.map((item) => AppointmentTypeModel.fromJson(item)));
  }

  static Future<List<AppointmentTypeModel>> getData() async {
    final response = await http.get(Uri.parse(_viewUrl));
    if (response.statusCode == 200) {
      List<AppointmentTypeModel> list = availabilityFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<AppointmentTypeModel>> getDataByDId(String id) async {
    print("JJJJJJJJJJJJJJJJJJJJ $_viewUrlDId?doctId=$id}");
    final response = await http.get(Uri.parse("$_viewUrlDId?doctId=$id"));
    if (response.statusCode == 200) {
      List<AppointmentTypeModel> list = availabilityFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
