import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateData {
  static Future<String> updateTimeSlot(
      serviceTimeMin, timeSlots, date, appointmentId,doctId) async {
    List bookedTimeSlots = [];
    String res = "";
    final ref = FirebaseFirestore.instance
        .collection('bookedTimeSlots').doc(doctId).collection(doctId)
        .doc(
      date
    );
    await ref.get().then((snapshot) async {
      if (snapshot.data() == null) {
        //bookedTimeSlots = snapshot.data()["bookedTimeSlots"];
        bookedTimeSlots = [
          {
            "bookedTime": timeSlots,
            "forMin": serviceTimeMin,
            "appointmentId": appointmentId
          }
        ];
        await ref.set({"bookedTimeSlots": bookedTimeSlots}).catchError((e) {
          print(e);
          res = "error";
        });
      } else {
        bookedTimeSlots = snapshot.data()["bookedTimeSlots"];
        bookedTimeSlots.add({
          "bookedTime": timeSlots,
          "forMin": serviceTimeMin,
          "appointmentId": appointmentId
        });

        await ref.update({"bookedTimeSlots": bookedTimeSlots}).catchError((e) {
          print(e);
          res = "error";
        });
      }
    }).catchError((e) => {print(e), res = "error"});
    return res;
  }

  static Future <String>updateIsAnyNotification(String collection, String uId,bool isAnyNotification) async {


    final res =await FirebaseFirestore.instance.collection(collection)
        .doc(uId).update(
        {
          "isAnyNotification":isAnyNotification
        }
    ).then((value) {return "success";}).catchError((onError){return"error";});
    return res;
  }

}
