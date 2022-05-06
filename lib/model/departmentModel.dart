class DepartmentModel{
  String id;
  String name;
  String imageUrl;
  DepartmentModel({
    this.id,
    this.name,
    this.imageUrl,
  });
  factory DepartmentModel.fromJson(Map<String,dynamic> json){
    return DepartmentModel(
        id:json['id'].toString(),
        name:json['name'],
        imageUrl:json['imageUrl'],

    );
  }
}