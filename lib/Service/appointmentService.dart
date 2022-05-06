import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/appointmentModel.dart';

class AppointmentService {
  static const _viewUrl = "$apiUrl/get_appointment_by_status";
  static const _addUrl = "$apiUrl/add_appointment";
  static const _updateStatusUrl = "$apiUrl/update_appointment_status";

  static List<AppointmentModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<AppointmentModel>.from(
        data.map((item) => AppointmentModel.fromJson(item)));
  }

  static Future<List<AppointmentModel>> getData(String forStatus) async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    final status = forStatus;
    print(status);

    final response =
        await http.get(Uri.parse("$_viewUrl?uid=$userId&status=$status"));
    if (response.statusCode == 200) {
      List<AppointmentModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static addData(AppointmentModel appointmentModel) async {
    final res =
        await http.post(Uri.parse(_addUrl), body: appointmentModel.toJsonAdd());
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

  static updateStatus(AppointmentModel appointmentModel) async {
    final res = await http.post(Uri.parse(_updateStatusUrl),
        body: appointmentModel.toJsonUpdateStatus());
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
}
