import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteData{
  static Future deleteBookedAppointment( String appointmentId,String appointmentDate,String doctId)async {
    String res;
    final bookedAppointmentList=await FirebaseFirestore.instance.collection('bookedTimeSlots').doc(doctId).collection(doctId)
        .doc(appointmentDate).get().then((value) { return value["bookedTimeSlots"];}).catchError((onError){
      print("Error");
      print(onError);
    });

    for (int i=0;i<bookedAppointmentList.length;i++) {
      if (bookedAppointmentList[i]["appointmentId"] == appointmentId) {
        bookedAppointmentList.removeAt(i);
      }
    }
    print(bookedAppointmentList);
    await  FirebaseFirestore.instance.collection('bookedTimeSlots').doc(doctId).collection(doctId).doc(appointmentDate).update({
      "bookedTimeSlots":bookedAppointmentList
    }).then((value) {
      res="success";
    }).catchError ((onError){

      res= "error";
    });

    return res;



  }
}