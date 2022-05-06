
class BannerImageModel{
  String banner1;
  String banner2;
  String banner3;
  String banner4;
  String clinicImage;

  BannerImageModel({
    this.banner1,
    this.banner2,
    this.banner3,
    this.banner4,
    this.clinicImage,

  });

  factory BannerImageModel.fromJson(Map<String,dynamic> json){
    return BannerImageModel(

      banner1: json['banner1'],
      banner2: json['banner2'],
      banner3: json['banner3'],
      banner4: json['banner4'],
      clinicImage: json['clinicImage'],

    );
  }

}