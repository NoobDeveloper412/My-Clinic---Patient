
class AppointmentTypeModel{
  String title;
  String imageUrl;
  int forTimeMin;
  String subTitle;
  String openingTime;
  String closingTime;
  String day;


  AppointmentTypeModel({
    this.title,
    this.imageUrl,
    this.forTimeMin,
    this.subTitle,
    this.openingTime,
    this.closingTime,
    this.day
  });

  factory AppointmentTypeModel.fromJson(Map<String,dynamic> json){
    return AppointmentTypeModel(
      title: json['title'],
      imageUrl: json['imageUrl'],
      forTimeMin:  int.parse(json['forTimeMin']),
      subTitle: json['subTitle'],
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
      day: json['day']
    );
  }

}