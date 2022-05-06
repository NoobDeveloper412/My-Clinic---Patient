
class CheckPaymentModel{
  String uid;
  String oderId;

  CheckPaymentModel({
    this.uid,
    this.oderId,
  });

  factory CheckPaymentModel.fromJson(Map<String,dynamic> json){
    return CheckPaymentModel(
        uid: json['uid'],
        oderId: json['oderId'],
    );
  }

}