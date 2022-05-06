
class DrProfileModel{
  String firstName;
  String lastName;
  String email;
  String pNo1;
  String pNo2;
  String description;
  String whatsAppNo;
  String subTitle;
  String profileImageUrl;
  String address;
  String aboutUs;
  String fdmId;
  String deptId;
  String hName;
  String id;
  String lunchOpeningTime;
  String lunchClosingTime;
  String closingDate;
  String opt;
  String clt;
  String dayCode;
  String serviceTime;
  String stopBooking;
  String fee;

  DrProfileModel({
    this.firstName,
    this.lastName,
    this.email,
    this.pNo1,
    this.pNo2,
    this.description,
    this.whatsAppNo,
    this.subTitle,
    this.profileImageUrl,
    this.address,
    this.aboutUs,
    this.fdmId,
    this.deptId,
    this.hName,
    this.id,
    this.lunchOpeningTime,
    this.lunchClosingTime,
    this.closingDate,
    this.dayCode,
    this.clt,
    this.opt,
    this.serviceTime,
    this.stopBooking,
    this.fee
  });

  factory DrProfileModel.fromJson(Map<String,dynamic> json){
    return DrProfileModel(

      firstName: json['firstName'],
      lastName: json['lastName'],
      pNo1: json['pNo1'],
      pNo2: json['pNo2'],
      email: json['email'],
      subTitle: json['subTitle'],
      description: json['description'],
      whatsAppNo: json['whatsAppNo'],
      profileImageUrl: json['profileImageUrl'],
      address: json['address'],
      aboutUs: json['aboutUs'],
      fdmId: json['fcmId'],
      deptId: json['deptId'],
      hName: json['hName'],
      id: json['id'].toString(),
      lunchClosingTime: json["lct"],
      lunchOpeningTime: json['lot'],
      closingDate: json['closingDate'],
        opt: json["opt"],
        clt: json['clt'],
        dayCode: json['dayCode'],
        serviceTime:json['timeInt'],
      stopBooking: json['stopBooking'],
      fee: json['fee']
    );
  }

}