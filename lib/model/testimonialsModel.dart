
class TestimonialsModel{
  String name;
  String description;
  String imageUrl;


  TestimonialsModel({
    this.imageUrl,
    this.description,
    this.name


  });

  factory TestimonialsModel.fromJson(Map<String,dynamic> json){
    return TestimonialsModel(

      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],

    );
  }

}