import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/drProfielModel.dart';

class DrProfileService {
  static const _viewUrl = "$apiUrl/get_ab";
  static const _viewUrlByDeptId = "$apiUrl/get_drbydeptclinic";
  static const _viewUrlByCity = "$apiUrl/get_dr_bycity";
  static const _viewUrlByDrId = "$apiUrl/get_dr_byid";



  static List<DrProfileModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<DrProfileModel>.from(
        data.map((item) => DrProfileModel.fromJson(item)));
  }

  static Future<List<DrProfileModel>> getData() async {
    final response = await http.get(Uri.parse(_viewUrl));
    if (response.statusCode == 200) {
      List<DrProfileModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
  static Future<List<DrProfileModel>> getDataByCityId(String cityId) async {
    print("$_viewUrlByCity?cityId=$cityId");
    final response = await http.get(Uri.parse("$_viewUrlByCity?cityId=$cityId"));
    if (response.statusCode == 200) {
      List<DrProfileModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }


  static Future<List<DrProfileModel>> getDataById(String id,String clinicId,String cityId) async {
    final response = await http.get(Uri.parse("$_viewUrlByDeptId?deptId=$id&clinicId=$clinicId&cityId=$cityId"));
    if (response.statusCode == 200) {
      List<DrProfileModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
  static Future<List<DrProfileModel>> getDataByDrId(String doctId) async {
    final response = await http.get(Uri.parse("$_viewUrlByDrId?id=$doctId"));
    if (response.statusCode == 200) {
      List<DrProfileModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
