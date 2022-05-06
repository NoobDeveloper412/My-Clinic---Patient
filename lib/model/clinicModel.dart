
class ClinicModel {
  String id;
  String title;
  String imageUrl;
  String location;
  String locationName;

  ClinicModel({
    this.id,
    this.title,
    this.imageUrl,
    this.location,
    this.locationName
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json){
    return ClinicModel(
      locationName: json['location_name'],
        imageUrl: json['imageUrl'],
        location: json['location'],
        title: json['title'],
        id: json['id'].toString(),
    );
  }

}