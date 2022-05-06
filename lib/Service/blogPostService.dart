import 'dart:convert';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/blogPostModel.dart';
import 'package:http/http.dart' as http;

class BlogPostService {
  static const _viewUrl = "$apiUrl/get_blog_post_by_status";

  static List<BlogPostModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<BlogPostModel>.from(
        data.map((item) => BlogPostModel.fromJson(item)));
  }

  static Future<List<BlogPostModel>> getData(int getLimit) async {
    String limit = getLimit.toString();
    final response = await http.get(Uri.parse("$_viewUrl?limit=$limit"));
    if (response.statusCode == 200) {
      List<BlogPostModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }
}
