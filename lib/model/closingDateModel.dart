
class ClosingDateModel{
  String date;
  String id;


  ClosingDateModel({
    this.id,
    this.date
  });

  factory ClosingDateModel.fromJson(Map<String,dynamic> json){
    return ClosingDateModel(
        id:json['id'].toString(),
        date:json['date'],

    );
  }

}