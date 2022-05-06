
class BlogPostModel {
  String body;
  String title;
 String createdTimeStamp;
  String updatedTimeStamp;
   String thumbImageUrl;
   String status;
   String id;
   String fileName;


  BlogPostModel({
    this.body,
    this.title,
    this.createdTimeStamp,
    this.updatedTimeStamp,
    this.thumbImageUrl,
    this.status,
    this.id,
    this.fileName
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> json){
    return BlogPostModel(

        body: json['body'],
        createdTimeStamp: json['createdTimeStamp'],
        updatedTimeStamp: json['updatedTimeStamp'],
        title: json['title'],
      thumbImageUrl: json['thumbImageUrl'],
      id: json['id'],
      status: json['status'],
        fileName: json['fileName']


    );
  }

}