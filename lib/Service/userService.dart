import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/userModel.dart';

class UserService {
  static const _viewUrl = "$apiUrl/get_user";
  static const _addUrl = "$apiUrl/add_user";
  static const _update = "$apiUrl/update_user_fcm";
  static const _updateUrl = "$apiUrl/update_user";
  static List<UserModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<UserModel>.from(data.map((item) => UserModel.fromJson(item)));
  }

  static Future<List<UserModel>> getData() async {
    final userId = FirebaseAuth.instance.currentUser.uid;
   // print("UUUUUUUUUUUUIIIIIIIIIIIIIDDDDDDDD$userId");

    final response = await http.get(Uri.parse("$_viewUrl?uid=$userId"));
    if (response.statusCode == 200) {
      List<UserModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }

  static addData(UserModel appointmentModel) async {
    final res =await http.post(Uri.parse(_addUrl), body: appointmentModel.toJsonAdd());
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

  static updateFcmId(String uId, String fcmId) async {
    final res = await http
        .post(Uri.parse("$_update"), body: {"fcmId": fcmId, "uid": uId});
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

  static updateData(UserModel userModel) async {
    final res =
        await http.post(Uri.parse(_updateUrl), body: userModel.toUpdateJson());
    print(">>>>>>>>>>>>>>>>>>>>>>${res.body}");
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
}
