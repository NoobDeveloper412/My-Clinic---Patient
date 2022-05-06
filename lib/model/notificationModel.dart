
class NotificationModel{
  String body;
  String routeTo;
  String sendBy;
  String sendFrom;
  String sendTo;
  String title;
  String uId;
  String createdTimeStamp;
  String doctId;

  NotificationModel({
  this.body,
    this.title,
    this.uId,
    this.routeTo,
    this.sendTo,
    this.createdTimeStamp,
    this.sendBy,
    this.sendFrom,
    this.doctId



  });

  factory NotificationModel.fromJson(Map<String,dynamic> json){
    return NotificationModel(
      title:json['title'],
      body:json['body'],
      sendFrom:json['sendFrom'],
      sendBy:json['sendBy'],
      sendTo:json['sendTo'],
      routeTo:json['routeTo'],
      uId:json['uId'],
        createdTimeStamp:json['createdTimeStamp']

    );
  }
  Map<String,dynamic> toJsonAdd(){
    return {
      "title":this.title,
      "body":this.body,
      "sendFrom":this.sendFrom,
      "sendBy":this.sendBy,
      "sendTo":this.sendTo,
      "routeTo":this.routeTo,
      "uId":this.uId
    };
  }
  Map<String,dynamic> toJsonAddForAdmin(){
    return {
      "title":this.title,
      "body":this.body,
      "sendBy":this.sendBy,
      "uId":this.uId,
      "doctId":this.doctId
    };

  }
}