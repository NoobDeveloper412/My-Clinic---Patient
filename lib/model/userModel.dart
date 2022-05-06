
class UserModel{
  String firstName;
  String lastName;
  String uId; //fcm id
  String city;
  String email;
  String fcmId;
  String imageUrl;
  String pNo;
  String searchByName;
  String age;
  String gender;
  String createdDate;
  String id;

  UserModel({
    this.firstName,
    this.lastName,
    this.uId,//firebase uid
    this.city,
    this.email,
    this.fcmId,
    this.imageUrl,
    this.pNo,
    this.searchByName,
    this.age,
    this.gender,
    this.createdDate,
    this.id

  });

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      firstName:json['firstName'],
      lastName:json['lastName'],
      uId:json['uId'],
      city:json['city'],
      email:json['email'],
      fcmId:json['fcmId'],
      imageUrl:json['imageUrl'],
      pNo:json['pNo'],
      searchByName:json['searchByName'],
      age:json['age'],
        gender: json['gender'],
        createdDate:json['createdTimeStamp'],
      id: json['id'].toString()

    );
  }
  Map<String,dynamic> toJsonAdd(){
    return {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "uId": this.uId, //firebase uid
      "city": this.city,
      "email": this.email,
      "fcmId": this.fcmId,
      "imageUrl": this.imageUrl,
      "pNo": this.pNo,
      "searchByName":this.searchByName,
      "age": this.age,
      "gender":this.gender
    };

  }
  Map<String,dynamic> toUpdateJson(){
    return {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "city": this.city,
      "age": this.age,
      "email": this.email,
      "imageUrl": this.imageUrl,
      "searchByName":this.searchByName,
      "uId": this.uId,
      "gender":this.gender
    };

  }
}