import 'package:cloud_firestore/cloud_firestore.dart';

class ReadData {
  //
  // static Future fetchOpeningClosingTime() async {
  //
  //
  //   final firebaseInstance=await FirebaseFirestore.instance
  //       .collection("timing")
  //       .doc("clinicTiming")
  //       .get();
  //
  //   return firebaseInstance;
  // }
  static Future<List> fetchBookedTime(selectedDate,doctId) async {
    List bookedTimeslots;
    await FirebaseFirestore.instance
        .collection("bookedTimeSlots")
    .doc(doctId).collection(doctId)
        .doc(selectedDate)
        .get()
        .then((snapshot) =>
            {bookedTimeslots = snapshot.data()["bookedTimeSlots"]})
        .catchError((e) => {print(e)});

    return bookedTimeslots;
  }



  static  fetchNotificationDotStatus(String uId)  {
    final firebaseInstance =  FirebaseFirestore.instance.collection(
        'usersList').doc(uId).snapshots();
    //doc(settingName).snapshots();

    return firebaseInstance;
  }
  static Future fetchSettings() async {
    final querySnapshot=await FirebaseFirestore.instance
        .collection('settings').doc("settings").get();   //carefully mentioned collection and doc name other wise data will not fetched properly

    return querySnapshot; //return the DocumentSnapshot
  }
}
