import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/bannerImageModel.dart';

class BannerImageService {
  static const _viewUrl = "$apiUrl/get_bannerImage";

  static List<BannerImageModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<BannerImageModel>.from(
        data.map((item) => BannerImageModel.fromJson(item)));
  }

  static Future<List<BannerImageModel>> getData() async {
    final response = await http.get(Uri.parse(_viewUrl));
    if (response.statusCode == 200) {
      List<BannerImageModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
