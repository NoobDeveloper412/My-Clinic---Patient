
class GalleryModel{

  String imageUrl;


  GalleryModel({
    this.imageUrl,



  });

  factory GalleryModel.fromJson(Map<String,dynamic> json){
    return GalleryModel(

      imageUrl: json['imageUrl'],

    );
  }

}