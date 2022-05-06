import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/clinicModel.dart';
import 'package:http/http.dart' as http;

class ClinicService {
  static const _viewUrl = "$apiUrl/get_clinic";

  static List<ClinicModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<ClinicModel>.from(
        data.map((item) => ClinicModel.fromJson(item)));
  }

  static Future<List<ClinicModel>> getData(String cityId) async {
    final response = await http.get(Uri.parse("$_viewUrl?cityId=$cityId"));
    if (response.statusCode == 200) {
      List<ClinicModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
