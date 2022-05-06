
import 'package:cloud_firestore/cloud_firestore.dart';
class AddData {

  static Future<String> addRegisterDetails(uid) async {
    var sendData = {"uId": uid, "isAnyNotification": false};
    String res = "";
    await FirebaseFirestore.instance
        .collection('usersList')
        .doc(uid)
        .set(sendData)
        .then((value) {
      res = "success";
    }).catchError((onError) {
      print(onError);
      res = "error";
    });
    return res;
  }

}
