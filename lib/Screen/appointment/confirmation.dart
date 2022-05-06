
import 'package:demopatient/Screen/paypalWebView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demopatient/Service/Firebase/updateData.dart';
import 'package:demopatient/Service/Noftification/handleFirebaseNotification.dart';
import 'package:demopatient/Service/Noftification/handleLocalNotification.dart';
import 'package:demopatient/Service/appointmentService.dart';
import 'package:demopatient/Service/drProfileService.dart';
import 'package:demopatient/Service/notificationService.dart';
import 'package:demopatient/SetData/screenArg.dart';
import 'package:demopatient/config.dart';
import 'package:demopatient/model/appointmentModel.dart';
import 'package:demopatient/model/notificationModel.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/utilities/toastMsg.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConfirmationPage extends StatefulWidget {

  ConfirmationPage({Key key}) : super(key: key);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  String _adminFCMid;
  String doctorFcm;
  bool _isLoading = false;
  String _isBtnDisable = "false";
  String _uId = "";
  String _uName = "";
  int paymentValue=1;

  double _amount=0;
  bool isOnline=false;
  //static const platform = const MethodChannel("razorpay_flutter");
  PatientDetailsArg _patientDetailsArgs;

  Razorpay _razorpay;
  int _paymentMeth=1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAndSetUserData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
  void openCheckout() async {
    var options = {
      'key': razorpayKeyId,
      'amount':_amount*100,

      'name': _patientDetailsArgs.pFirstName+" "+_patientDetailsArgs.pLastName,
      'description': _patientDetailsArgs.serviceName,
      'prefill': {'contact': _patientDetailsArgs.pPhn, 'email': _patientDetailsArgs.pEmail},
      "notify": {
        "sms": true,
        "email": true
      },
      "method": {
        "netbanking": true,
        "card": true,
        "wallet": false,
        'upi': true,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{

    _updateBookedPayLaterSlot(
        _patientDetailsArgs.pFirstName,
        _patientDetailsArgs.pLastName,
        _patientDetailsArgs.pPhn,
        _patientDetailsArgs.pEmail,
        _patientDetailsArgs.age,
        _patientDetailsArgs.gender,
        _patientDetailsArgs.pCity,
        _patientDetailsArgs.desc,
        _patientDetailsArgs.serviceName,
        _patientDetailsArgs.serviceTimeMIn,
        _patientDetailsArgs.selectedTime,
        _patientDetailsArgs.selectedDate,
        _patientDetailsArgs.doctName,
        _patientDetailsArgs.deptName,
        _patientDetailsArgs.hName,
        _patientDetailsArgs.doctId,
        "Paid",
        response.paymentId,
        "online",
      _patientDetailsArgs.cityId,
      _patientDetailsArgs.clinicId,
      _patientDetailsArgs.deptId
    );
    ToastMsg.showToastMsg("Payment success, please don't press back button");


  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message,
    //     toastLength: Toast.LENGTH_SHORT);
    ToastMsg.showToastMsg("Something went wrong");
    setState(() {
      _isLoading=false;
      _isBtnDisable="false";
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, toastLength: Toast.LENGTH_SHORT);
  }

  _getAndSetUserData() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _uName = prefs.getString("firstName") + " " + prefs.getString("lastName");
      _uId = prefs.getString("uid");
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _patientDetailsArgs =
        ModalRoute.of(context).settings.arguments;

    if(_patientDetailsArgs.serviceName=="Online")setState(() {
      isOnline=true;
    });
    else   isOnline=false;
    _amount=double.parse(_patientDetailsArgs.fee);
    return Scaffold(
        bottomNavigationBar: BottomNavigationStateWidget(
          title: "Confirm Appointment",
          onPressed: () async{
            if(paymentValue==0){
              _updateBookedPayLaterSlot(
                  _patientDetailsArgs.pFirstName,
                  _patientDetailsArgs.pLastName,
                  _patientDetailsArgs.pPhn,
                  _patientDetailsArgs.pEmail,
                  _patientDetailsArgs.age,
                  _patientDetailsArgs.gender,
                  _patientDetailsArgs.pCity,
                  _patientDetailsArgs.desc,
                  _patientDetailsArgs.serviceName,
                  _patientDetailsArgs.serviceTimeMIn,
                  _patientDetailsArgs.selectedTime,
                  _patientDetailsArgs
                      .selectedDate,
                  _patientDetailsArgs.doctName,
                  _patientDetailsArgs.deptName,
                  _patientDetailsArgs
                      .hName,
                  _patientDetailsArgs.doctId,
                  "Pay Later",
                  "",
                  "Pay Later",
                _patientDetailsArgs.cityId,
                _patientDetailsArgs.clinicId,
                _patientDetailsArgs.deptId
              );
            }

            else if(paymentValue==1){
              setState(() {
                _isLoading=true;
                _isBtnDisable = "";
              });
              if(_paymentMeth==1)
               { setState(() {
                 _isLoading=false;
                 _isBtnDisable = "true";
               });
                 Navigator.of(context).push(
                   MaterialPageRoute(
                     builder: (BuildContext context) => PaypalPayment(
                       itemPrice: _amount,
                       onFinish: (number) async {
                         setState(() {
                           _isLoading=true;
                           _isBtnDisable = "";
                         });
                         print('order id******************************************************: '+number);
                         _updateBookedPayLaterSlot(
                             _patientDetailsArgs.pFirstName,
                             _patientDetailsArgs.pLastName,
                             _patientDetailsArgs.pPhn,
                             _patientDetailsArgs.pEmail,
                             _patientDetailsArgs.age,
                             _patientDetailsArgs.gender,
                             _patientDetailsArgs.pCity,
                             _patientDetailsArgs.desc,
                             _patientDetailsArgs.serviceName,
                             _patientDetailsArgs.serviceTimeMIn,
                             _patientDetailsArgs.selectedTime,
                             _patientDetailsArgs.selectedDate,
                             _patientDetailsArgs.doctName,
                             _patientDetailsArgs.deptName,
                             _patientDetailsArgs.hName,
                             _patientDetailsArgs.doctId,
                             "Paid",
                             number.toString(),
                             "online",
                             _patientDetailsArgs.cityId,
                             _patientDetailsArgs.clinicId,
                             _patientDetailsArgs.deptId
                         );
                         ToastMsg.showToastMsg("Payment success, please don't press back button");
                         //  _handleAddData(isCOD: false,paymentID: number,paymentMode:"paypal");

                       },
                     ),
                   ),
                 );
               }
                else
              openCheckout();



            }  // Method handles all the booking system operation.
          },
          clickable: _isBtnDisable,
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CAppBarWidget(title: "Booking Confirmation"),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: IBoxDecoration.upperBoxDecoration(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, right: 10),
                          child: _isLoading
                              ? Center(child: LoadingIndicatorWidget())
                              : Center(
                            child: Container(
                              // height: 350,
                                width: double.infinity,
                                child: _cardView(_patientDetailsArgs)),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));

    //    Container(
    //       color: bgColor,
    //       child: _isLoading
    //           ? Center(child: CircularProgressIndicator())
    //           : Center(
    //               child: Container(
    //                   height: 250,
    //                   width: double.infinity,
    //                   child: _cardView(patientDetailsArgs)),
    //             )),
    // );
  }

  Widget _cardView( PatientDetailsArg args) {
    return Card(
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appBarColor,
              ),
              child: Center(
                child: Text(
                  "Please Confirm All Details",
                  style: TextStyle(
                    fontFamily: 'OpenSans-SemiBold',
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Divider(),
            Text(
              "Patient Name - ${args.pFirstName} " + "${args.pLastName}",
              style: kCardSubTitleStyle,
            ),
            SizedBox(height: 10),
            Text("Service Name - ${args.serviceName}",
                style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("Service Time - ${args.serviceTimeMIn} Minute",
                style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("Date - ${args.selectedDate}", style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("Time - ${args.selectedTime}", style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("City - ${args.cityName}", style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("Clinic - ${args.clinicName}", style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("Doctor Name - ${args.doctName}", style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("Department - ${args.deptName}", style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("Hospital Name - ${args.hName}", style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("Mobile Number - ${args.pPhn}", style: kCardSubTitleStyle),
            SizedBox(height: 10),
            Text("Amount - $_amount", style: kCardSubTitleStyle),
            ListTile(
              title: const Text('Pay Now'),
              leading: Radio(
                value:1,
                groupValue: paymentValue,
                onChanged: (value) {
                  setState(() {
                    paymentValue = value;
                  });
                },
              ),
            ),
            paymentValue==1?ListTile(
              title: const Text('Paypal Payment'),
              leading: Radio(
                value:1,
                groupValue: _paymentMeth,
                onChanged: (value) {
                  setState(() {
                    _paymentMeth = value;
                  });
                },
              ),
            ):Container(),
            paymentValue==1?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Note: Please use this id and password for paypal test payment\nEmail: MyclinicTest@paypal.com\nPassword: 12345678",
              style: TextStyle(
                color: Colors.red
              ),),
            ):Container(
            ),

            paymentValue==1?ListTile(
              title: const Text('Razorpay Indian Payment'),
              leading: Radio(
                value:0,
                groupValue: _paymentMeth,
                onChanged: (value) {
                  setState(() {
                    _paymentMeth = value;
                  });
                },
              ),
            ):Container(),
            args.serviceName=="Online"?Container():  ListTile(
              title: const Text('Pay Later'),
              leading: Radio(
                value:0,
                groupValue: paymentValue,
                onChanged: (value) {
                  setState(() {
                    paymentValue = value;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateBookedPayLaterSlot(pFirstName, pLastName, pPhn, pEmail, age, gender,
      pCity, desc, serviceName, serviceTimeMin, setTime, selectedDate,
      String doctName,
      String department,
      String hName,
      String doctId,
      paymentStatus,
      paymentId,
      payMode,
      cityId,
      clinicId,
      deptId
      ) async {
    setState(() {
      _isLoading = true;
      _isBtnDisable = "";
    });
    final pattern = RegExp('\\s+'); //remove all space
    final patientName = pFirstName + pLastName;
    String searchByName = patientName
        .toLowerCase()
        .replaceAll(pattern, ""); //lowercase all letter and remove all space

    final appointmentModel = AppointmentModel(
        pFirstName: pFirstName,
        pLastName: pLastName,
        pPhn: pPhn,
        pEmail: pEmail,
        age: age,
        gender: gender,
        pCity: pCity,
        description: desc,
        serviceName: serviceName,
        serviceTimeMin: serviceTimeMin,
        appointmentTime: setTime,
        appointmentDate: selectedDate,
        appointmentStatus: "Pending",
        searchByName: searchByName,
        uId: _uId,
        uName: _uName,
        doctId: doctId,
        department: department,
        doctName: doctName,
        hName: hName,
        paymentStatus: paymentStatus,
        oderId:paymentId ,
        amount: _amount.toString(),
        paymentMode: payMode,
        deptId: deptId,
        cityId: cityId,
        clinicId: clinicId,
        isOnline: isOnline?"true":"false"); //initialize all values
    final insertStatus = await AppointmentService.addData(appointmentModel);

    if (insertStatus != "error") {
      print(":::::::::::::::::::::;$insertStatus");
      final updatedTimeSlotsStatus = await UpdateData.updateTimeSlot(
          serviceTimeMin, setTime, selectedDate, insertStatus,doctId);
      //if appoint details added successfully added

      if (updatedTimeSlotsStatus == "") {
        final notificationModel = NotificationModel(
            title: "Successfully Booked",
            body:
            "Appointment has been booked on $selectedDate. Waiting for confirmation",
            uId: _uId,
            routeTo: "/Appointmentstatus",
            sendBy: "user",
            sendFrom: _uName,
            sendTo: "Admin");
        final notificationModelForAdmin = NotificationModel(
            title: "New Appointment",
            body:
            "$pFirstName $pLastName booked an appointment on $selectedDate at $setTime",
            uId: _uId,
            sendBy: _uName,
        doctId: doctId);

        final msgAdded = await NotificationService.addData(notificationModel);

        if (msgAdded == "success") {
          await NotificationService.addDataForAdmin(notificationModelForAdmin);
          SharedPreferences _prefs=await SharedPreferences.getInstance();
          try{
            _prefs.getStringList("patientData").clear();
            _prefs.setBool("inPaymentState", false);
          }catch(e){
            print(e);
          }
          ToastMsg.showToastMsg("Successfully Booked");
          _handleSendNotification(
              pFirstName, pLastName, serviceName, selectedDate, setTime,doctId);

        } else if (msgAdded == "error") {
          ToastMsg.showToastMsg("Something went wrong. try again");

          Navigator.pop(context);
        }
      } else {
        ToastMsg.showToastMsg("Something went wrong. try again");
        Navigator.pop(context);
      }
    } else {
      ToastMsg.showToastMsg("Something went wrong. try again");
      Navigator.pop(context);
    }

    setState(() {
      _isLoading = false;
      _isBtnDisable = "false";
    });
  }

  Future <String> _setAdminFcmId(doctId) async {
    //loading if data till data fetched
    setState(() {
      _isLoading = true;
    });
    final res = await DrProfileService
        .getData(); //fetch admin fcm id for sending messages to admin
    if (res != null) {
      setState(() {
        _adminFCMid = res[0].fdmId;
      });
    }
    final res2 = await DrProfileService.getDataByDrId(doctId); //fetch admin fcm id for sending messages to admin
    if (res2 != null) {
      setState(() {
        doctorFcm = res2[0].fdmId;
      });
    }
    setState(() {
      _isLoading = false;
    });
    return "";
  }

  void _handleSendNotification(String firstName, String lastName,
      String serviceName, String selectedDate, String setTime,doctId) async {
    setState(() {
      _isLoading=true;
      _isBtnDisable = "";
    });
     await _setAdminFcmId(doctId);
    await HandleLocalNotification.showNotification(
      "Successfully Booked", //title
      "Appointment has been booked on $selectedDate. Waiting for confirmation", // body
    );
    await UpdateData.updateIsAnyNotification("usersList", _uId, true);

    //send notification to admin app for booking confirmation
    print("++++++++++++admin$_adminFCMid");
     print("++++++++++++doctor$doctorFcm");
    await HandleFirebaseNotification.sendPushMessage(
        _adminFCMid, //admin fcm
        "New Appointment", //title
        "$firstName $lastName booked an appointment on $selectedDate at $setTime" //body
    );
    await HandleFirebaseNotification.sendPushMessage(
        doctorFcm, //admin fcm
        "New Appointment", //title
        "$firstName $lastName booked an appointment on $selectedDate at $setTime" //body
    );
    await UpdateData.updateIsAnyNotification("doctorsNoti", doctId, true);
    await UpdateData.updateIsAnyNotification("profile", "profile", true);

     Navigator.of(context).pushNamedAndRemoveUntil(
         '/Appointmentstatus', ModalRoute.withName('/'));
  }
}
