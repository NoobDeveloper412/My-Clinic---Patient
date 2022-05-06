
class ServiceModel{
  String title;
  String subTitle;
  String imageUrl;
  String desc;
  String url;


  ServiceModel({
this.imageUrl,
    this.subTitle,
    this.title,
    this.desc,
    this.url


  });

  factory ServiceModel.fromJson(Map<String,dynamic> json){
    return ServiceModel(
      title: json['title'],
      subTitle: json['subTitle'],
      imageUrl: json['imageUrl'],
      desc: json['description'],
      url: json['url']
    );
  }

}