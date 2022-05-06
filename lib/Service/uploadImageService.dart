import 'package:demopatient/config.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart' as http;

class UploadImageService {
//uploadImages method upload the image using asset
  static Future<String> uploadImages(image) async {
    final imagePath = await getFilePath(image); //get image path
    final uri = Uri.parse("$apiUrl/upload_image.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = image.name;
    var pic = await http.MultipartFile.fromPath("image", imagePath);
    request.files.add(pic);
    var response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return responseBody;
    } else {
      return "error";
    }
  }

  static getFilePath(images) async {
    var path = await FlutterAbsolutePath.getAbsolutePath(
        images.identifier); //get path of the image from asset
    return path;
  }
}
