import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demopatient/config.dart';
import 'package:demopatient/model/checkPaymentModel.dart';

class CheckPaymentService {
  static List<CheckPaymentModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<CheckPaymentModel>.from(
        data.map((item) => CheckPaymentModel.fromJson(item)));
  }

  static getData(String uid, String odId) async {
    String _viewUrl = "$apiUrl/get_checkpaymntggggg?uid=$uid&oderId=$odId";
    try {
      final response = await http.get(Uri.parse(_viewUrl));
      if (response.statusCode == 200) {
        print("rrrrrrrrrrrrrrrrrrrrr${response.body}");
        List<CheckPaymentModel> list = dataFromJson(response.body);
        return list;
      } else {
        return []; //if any error occurs then it return a blank list
      }
    } catch (e) {
      return "error";
    }
  }
}
