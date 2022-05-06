import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/prescriptionModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class PrescriptionService {
  static const _viewUrl = "$apiUrl/get_prescription";
  static const _viewUrlById = "$apiUrl/get_prescription_byid";

  static List<PrescriptionModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<PrescriptionModel>.from(
        data.map((item) => PrescriptionModel.fromJson(item)));
  }

  static Future<List<PrescriptionModel>> getData() async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    final response =
        await http.post(Uri.parse(_viewUrl), body: {"uId": userId});
    if (response.statusCode == 200) {
      List<PrescriptionModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static Future<List<PrescriptionModel>> getDataByApId(
      {String appointmentId}) async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    final response = await http.post(Uri.parse(_viewUrlById),
        body: {"uId": userId, "appointmentId": appointmentId});
    if (response.statusCode == 200) {
      List<PrescriptionModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
