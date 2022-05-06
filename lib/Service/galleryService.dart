import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:http/http.dart' as http;
import 'package:demopatient/model/galleryModel.dart';

class GalleryService {
  static const _viewUrl = "$apiUrl/get_gallery";

  static List<GalleryModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<GalleryModel>.from(
        data.map((item) => GalleryModel.fromJson(item)));
  }

  static Future<List<GalleryModel>> getData() async {
    final response = await http.get(Uri.parse(_viewUrl));
    if (response.statusCode == 200) {
      List<GalleryModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
