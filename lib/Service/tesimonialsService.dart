import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/testimonialsModel.dart';

class TestimonialsService {
  static const _viewUrl = "$apiUrl/get_testimonials";

  static List<TestimonialsModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<TestimonialsModel>.from(
        data.map((item) => TestimonialsModel.fromJson(item)));
  }

  static Future<List<TestimonialsModel>> getData() async {
    final response = await http.get(Uri.parse(_viewUrl));
    if (response.statusCode == 200) {
      List<TestimonialsModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
