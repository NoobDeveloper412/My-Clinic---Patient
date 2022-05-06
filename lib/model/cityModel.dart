
class CityModel {
  String id;
  String title;
  String imageUrl;


  CityModel({
    this.id,
    this.title,
    this.imageUrl,
  });

  factory CityModel.fromJson(Map<String, dynamic> json){
    return CityModel(
      imageUrl: json['imageUrl'],
      title: json['cityName'],
      id: json['id'].toString(),
    );
  }

}