import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/departmentModel.dart';

class DepartmentService {
  static const _viewUrl = "$apiUrl/get_departmentbyid";

  static List<DepartmentModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<DepartmentModel>.from(
        data.map((item) => DepartmentModel.fromJson(item)));
  }

  static Future<List<DepartmentModel>> getData(String id,String cityID) async {
    final response = await http.get(Uri.parse("$_viewUrl?clinicId=$id&cityId=$cityID"));
    if (response.statusCode == 200) {
      List<DepartmentModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
