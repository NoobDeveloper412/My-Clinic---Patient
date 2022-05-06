

import 'package:demopatient/config.dart';
import 'package:demopatient/model/feedbackmodel.dart';
import 'package:http/http.dart' as http;


class FeedbackService {
  static const _addUrl = "$apiUrl/add_feedback";


  static addData(FeedbackModel feedbackModel) async {
    final res =
    await http.post(Uri.parse(_addUrl), body: feedbackModel.addJson());
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }

}
