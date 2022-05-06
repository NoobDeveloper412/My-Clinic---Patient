
class AppointmentModel{
  String appointmentDate;
  String appointmentStatus;
  String appointmentTime;
  String pCity;
  String age;
  String pEmail;
  String pFirstName;
  String pLastName;
  String serviceName;
  int serviceTimeMin;
  String uId;
  String pPhn;
  String description;
  String searchByName;
  String uName;
  String id;
  String createdTimeStamp;
  String updatedTimeStamp;
  String gender;
  String doctName;
  String department;
  String hName;
  String doctId;
 String  paymentStatus;
  String paymentDate;
  String oderId;
 String  amount;
 String  paymentMode;
  String isOnline;
  String gMeetLink;
  String  clinicId;
  String deptId;
  String cityId;
  String clinicName;
  String cityName;
  AppointmentModel({
    this.appointmentDate,
    this.appointmentStatus,
    this.appointmentTime,
    this.pCity,
    this.age,
    this.pEmail,
    this.pFirstName,
    this.pLastName,
    this.serviceName,
    this.serviceTimeMin,
    this.uId,
    this.pPhn,
    this.description,
    this.searchByName,
    this.uName,
    this.id,
    this.createdTimeStamp,
    this.updatedTimeStamp,
    this.gender,
    this.doctName,
    this.hName,
    this.department,
    this.doctId,
    this.amount,
    this.oderId,
    this.paymentMode,
    this.isOnline,
    this.gMeetLink,
    this.paymentStatus,
    this.paymentDate,
    this.clinicId,
    this.cityId,
    this.deptId,
    this.clinicName,
    this.cityName

  });

  factory AppointmentModel.fromJson(Map<String,dynamic> json){
    return AppointmentModel(
      appointmentDate:json['appointmentDate'],
      appointmentStatus:json['appointmentStatus'],
      appointmentTime:json['appointmentTime'],
      pCity:json['pCity'],
      age:json['age'],
      pEmail:json['pEmail'],
      pFirstName:json['pFirstName'],
      pLastName:json['pLastName'],
      serviceName:json['serviceName'],
      serviceTimeMin:int.parse(json['serviceTimeMin'],),
      uId:json['uId'],
      pPhn:json['pPhn'],
      description:json['description'],
      searchByName:json['searchByName'],
      uName:json['uName'],
        id:json['id'],
        createdTimeStamp:json['createdTimeStamp'],
        updatedTimeStamp:json['updatedTimeStamp'],
      gender: json['gender'],
        department:json['department'],
        doctName:json['doctName'],
        hName: json['hName'],
      doctId: json['doctId'],
        amount: json['amount'],
        paymentMode:json['paymentMode'],
        oderId: json["orderId"],
        paymentDate:json['paymentDate'],
        paymentStatus: json['paymentStatus'],
        isOnline: json['isOnline'],
        gMeetLink:json['gmeetLink'],
      clinicName: json['title'],
      cityName: json['cityName']

    );
  }
   Map<String,dynamic> toJsonAdd(){
    return {
      "appointmentDate":this.appointmentDate,
      "appointmentStatus":this.appointmentStatus,
      "appointmentTime":this.appointmentTime,
      "pCity":this.pCity,
      "age":this.age,
      "pEmail":this.pEmail,
      "pFirstName":this.pFirstName,
      'pLastName':this.pLastName,
      "serviceName":this.serviceName,
      "serviceTimeMin":(this.serviceTimeMin).toString(),
      "uId":this.uId,
      "pPhn":this.pPhn,
      "description":this.description,
      "searchByName":this.searchByName,
      "uName":this.uName,
      "gender":this.gender,
      "doctName":this.doctName,
      "department":this.department,
      "hName":this.hName,
      "doctId":this.doctId,
      "orderId":this.oderId,
      "paymentStatus":this.paymentStatus,
      "amount":this.amount,
      "paymentMode":this.paymentMode,
      "isOnline":this.isOnline,
      "clinicId":this.clinicId,
      "cityId":this.cityId,
      "deptId":this.deptId

          };

  }
  Map<String,dynamic> toJsonUpdateStatus(){
    return {

      "appointmentStatus":this.appointmentStatus,
      "id":this.id,

    };

  }
}