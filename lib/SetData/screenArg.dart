

// class ServiceScrAr {
//   final String serviceName;
//   final int serviceTimeMin;
//   final String openingTime;
//   final String closingTime;
//   ServiceScrArg(this.serviceName, this.serviceTimeMin,this.openingTime,this.closingTime);
// }

class ChooseTimeScrArg {
  final String serviceName;
  final int serviceTimeMIn;
  final String selectedTime;
  final String selectedDate;
  final String doctName;
  final String deptName;
  final String hName;
  final String doctId;
  final String fee;
  final clinicId;
  final cityId;
  final deptId;
  final cityName;
  final clinicName;


  ChooseTimeScrArg(this.serviceName, this.serviceTimeMIn, this.selectedTime,
      this.selectedDate,
      this.doctName,
      this.deptName,
      this.hName,
      this.doctId,
      this.fee,
      this.deptId,
      this.cityId,
      this.clinicId,
      this.clinicName,
      this.cityName
      );
}

class PatientDetailsArg {
  final String pFirstName;
  final String pLastName;
  final String pPhn;
  final String pEmail;
  final String age;
  final String gender;
  final String pCity;
  final String desc;
  final String serviceName;
  final int serviceTimeMIn;
  final String selectedTime;
  final String selectedDate;
  final String doctName;
  final String deptName;
  final String hName;
  final String doctId;
  final String fee;
  final clinicId;
  final cityId;
  final deptId;
  final cityName;
  final clinicName;

  PatientDetailsArg(
      this.pFirstName,
      this.pLastName,
      this.pPhn,
      this.pEmail,
      this.age,
      this.gender,
      this.pCity,
      this.desc,
      this.serviceName,
      this.serviceTimeMIn,
      this.selectedTime,
      this.selectedDate,
      this.doctName,
      this.deptName,
      this.hName,
      this.doctId,
      this.fee,
  this.deptId,
  this.cityId,
  this.clinicId,
      this.clinicName,
      this.cityName
      );
}



