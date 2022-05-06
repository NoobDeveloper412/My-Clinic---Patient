import 'package:demopatient/Screen/prescription/prescriptionListByIdPage.dart';
import 'package:demopatient/Service/Firebase/deletData.dart';
import 'package:demopatient/Service/Firebase/updateData.dart';
import 'package:demopatient/Service/Noftification/handleFirebaseNotification.dart';
import 'package:demopatient/Service/Noftification/handleLocalNotification.dart';
import 'package:demopatient/Service/appointmentService.dart';
import 'package:demopatient/Service/drProfileService.dart';
import 'package:demopatient/Service/notificationService.dart';
import 'package:demopatient/Screen/jitscVideoCall.dart';
import 'package:demopatient/model/appointmentModel.dart';
import 'package:demopatient/model/notificationModel.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/dialogBox.dart';
import 'package:demopatient/utilities/toastMsg.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';


class AppointmentDetailsPage extends StatefulWidget {
  final appointmentDetails;

  const AppointmentDetailsPage({Key key, this.appointmentDetails})
      : super(key: key);
  @override
  _AppointmentDetailsPageState createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _latsNameController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  TextEditingController _phnController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _serviceNameController = new TextEditingController();
  TextEditingController _statusController = new TextEditingController();
  TextEditingController _serviceTimeController = new TextEditingController();
  TextEditingController _appointmentIdController = new TextEditingController();
  TextEditingController _uIdController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _createdDateTimeController =
  new TextEditingController();
  TextEditingController _doctNameController = new TextEditingController();
  TextEditingController _deptController = new TextEditingController();
  TextEditingController _hnameController = new TextEditingController();
  TextEditingController _lastUpdatedController = new TextEditingController();
  TextEditingController _orderIdController = new TextEditingController();
  TextEditingController _paymentStatusController = new TextEditingController();
  TextEditingController _amountCont = new TextEditingController();
  TextEditingController _paymentModeCont = new TextEditingController();
  TextEditingController _paymentDateController = new TextEditingController();
  TextEditingController _appointmentStatusCont = new TextEditingController();
  TextEditingController _gmeetLinkCont = new TextEditingController();
  TextEditingController _cityName = new TextEditingController();
  TextEditingController _clinicName = new TextEditingController();
  String _isBtnDisable = "false";
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstNameController.text = widget.appointmentDetails.pFirstName;
    _latsNameController.text = widget.appointmentDetails.pLastName;
    _ageController.text = widget.appointmentDetails.age;
    _cityController.text = widget.appointmentDetails.pCity;
    _emailController.text = widget.appointmentDetails.pEmail;
    _phnController.text = widget.appointmentDetails.pPhn;
    _dateController.text = widget.appointmentDetails.appointmentDate;
    _timeController.text = widget.appointmentDetails.appointmentTime;
    _serviceNameController.text = widget.appointmentDetails.serviceName;
    _serviceTimeController.text =
        (widget.appointmentDetails.serviceTimeMin).toString();
    _appointmentIdController.text = widget.appointmentDetails.id;
    _uIdController.text = widget.appointmentDetails.uId; //firebase user id
    _descController.text = widget.appointmentDetails.description;
    _createdDateTimeController.text =
        widget.appointmentDetails.createdTimeStamp;
    _lastUpdatedController.text = widget.appointmentDetails.updatedTimeStamp;
    _statusController.text = widget.appointmentDetails.appointmentStatus;

    _doctNameController.text = widget.appointmentDetails.doctName;
    _deptController.text = widget.appointmentDetails.department;
    _hnameController.text = widget.appointmentDetails.hName;
    _cityName.text = widget.appointmentDetails.cityName;
    _clinicName.text = widget.appointmentDetails.clinicName;

    if (widget.appointmentDetails.appointmentStatus == "Rejected" ||
        widget.appointmentDetails.appointmentStatus == "Canceled") {
      setState(() {
        _isBtnDisable = "";
      });
    }
    _paymentStatusController.text = widget.appointmentDetails.paymentStatus;
    _paymentDateController.text = widget.appointmentDetails.paymentDate;
    _orderIdController.text = widget.appointmentDetails.oderId;
    _amountCont.text = widget.appointmentDetails.amount;
    _paymentModeCont.text = widget.appointmentDetails.paymentMode;
    if (widget.appointmentDetails.gMeetLink != null &&
        widget.appointmentDetails.gMeetLink != "")
      _gmeetLinkCont.text = widget.appointmentDetails.gMeetLink;
    else
      _gmeetLinkCont.text =
      "Please wait, Doctor will update the Google Meet link very soon";
    if (widget.appointmentDetails.isOnline == "true" &&
        widget.appointmentDetails.isOnline != null &&
        widget.appointmentDetails.isOnline != "")
      _appointmentStatusCont.text = "Online";
    else
      _appointmentStatusCont.text = "Offline";

    if (widget.appointmentDetails.appointmentStatus == "Rejected" ||
        widget.appointmentDetails.appointmentStatus == "Canceled" ||
        widget.appointmentDetails.paymentStatus == "SUCCESS") {
      setState(() {
        _isBtnDisable = "";
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _cityController.dispose();
    _ageController.dispose();
    _firstNameController.dispose();
    _latsNameController.dispose();
    _phnController.dispose();
    _emailController.dispose();
    _serviceNameController.dispose();
    _serviceTimeController.dispose();
    _appointmentIdController.dispose();
    _uIdController.dispose();
    _descController.dispose();
    _deptController.dispose();
    _doctNameController.dispose();
    _hnameController.dispose();
    _orderIdController.dispose();
    _paymentDateController.dispose();
    _paymentStatusController.dispose();
    _paymentModeCont.dispose();
    _orderIdController.dispose();
    _amountCont.dispose();
    _appointmentStatusCont.dispose();
    _gmeetLinkCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationStateWidget(
            title: widget.appointmentDetails.appointmentStatus == "Visited"
                ? "Get Prescription"
                : "Cancel",
            onPressed: widget.appointmentDetails.appointmentStatus == "Visited"
                ? _handlePrescription
                : _takeConfirmation,
            clickable: _isBtnDisable),
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CAppBarWidget(
              title: "Appointment Details",
            ),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: _isLoading
                    ? LoadingIndicatorWidget()
                    : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 0, right: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _appointmentStatusCont.text == "Online"
                            ? GestureDetector(
                          onTap: (){
                            print(widget.appointmentDetails.uId);
                            print(widget.appointmentDetails.doctId);
                            print(widget.appointmentDetails.pEmail);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Meeting(
                                    uid: widget.appointmentDetails.uId,
                                    doctid: widget.appointmentDetails.doctId,
                                    email: widget.appointmentDetails.pEmail,
                                  )),
                            );

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(
                                  40, 10, 40, 10),
                              child: Text(
                                "Call To Doctor",
                                style: TextStyle(
                                    fontFamily:
                                    "OpenSans-SemiBold",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                            : Container(),
                        SizedBox(height: 20),

                        _inputTextField(
                            "First Name", _firstNameController, 1),
                        _inputTextField(
                            "Last Name", _latsNameController, 1),
                        widget.appointmentDetails.oderId == ""
                            ? Container()
                            : _inputTextField("Amount", _amountCont, 1),
                        widget.appointmentDetails.oderId == ""
                            ? Container()
                            : _inputTextField(
                            "Payment Mode", _paymentModeCont, 1),
                        widget.appointmentDetails.oderId == ""
                            ? Container()
                            : _inputTextField(
                            "Payment Id", _orderIdController, 1),
                        _inputTextField("Payment Status",
                            _paymentStatusController, 1),
                        widget.appointmentDetails.oderId == ""
                            ? Container()
                            : _inputTextField("Payment Date",
                            _paymentDateController, 1),
                        _inputTextField("Age", _ageController, 1),
                        _inputTextField(
                            "Appointment Status", _statusController, 1),
                        _inputTextField(
                            "Phone Number", _phnController, 1),
                        _inputTextField("City ", _cityController, 1),
                        _inputTextField("Email", _emailController, 1),
                        _inputTextField(
                            "Appointment Date", _dateController, 1),
                        _inputTextField(
                            "Appointment Time", _timeController, 1),
                        _inputTextField("Appointment Minute",
                            _serviceTimeController, 1),
                        _inputTextField(
                            "Doctor Name", _doctNameController, 1),
                        _inputTextField("Clinic Name", _clinicName, 1),
                        _inputTextField("Clinic City", _cityName, 1),
                        _inputTextField("Department", _deptController, 1),
                        _inputTextField(
                            "Hospital", _hnameController, null),
                        _inputTextField("Appointment ID",
                            _appointmentIdController, 1),
                        _inputTextField("User ID", _uIdController, 1),
                        _inputTextField(
                            "Created on", _createdDateTimeController, 1),
                        _inputTextField(
                            "Last update on", _lastUpdatedController, 1),
                        _inputTextField("Description, About your problem",
                            _descController, null),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  _handlePrescription() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PrescriptionListByIDPage(
              appointmentId: widget.appointmentDetails.id)),
    );
  }

  Widget _inputTextField(String labelText, controller, maxLine) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: TextFormField(
        maxLines: maxLine,
        readOnly: true,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          // prefixIcon:Icon(Icons.,),
            labelText: labelText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).dividerColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            )),
      ),
    );
  }

  void _handleCancelBtn() async {
    setState(() {
      _isBtnDisable = "";
      _isLoading = true;
    });
    final res = await DeleteData.deleteBookedAppointment(
      widget.appointmentDetails.id,
      widget.appointmentDetails.appointmentDate,
      widget.appointmentDetails.doctId,
    );
    if (res == "success") {
      final appointmentModel = AppointmentModel(
          id: widget.appointmentDetails.id, appointmentStatus: "Canceled");
      final isUpdated = await AppointmentService.updateStatus(appointmentModel);
      if (isUpdated == "success") {
        final notificationModel = NotificationModel(
            title: "Canceled",
            body:
            "Appointment has been canceled for date ${widget.appointmentDetails.appointmentDate}. appointment id: ${widget.appointmentDetails.id}",
            uId: widget.appointmentDetails.uId,
            routeTo: "/Appointmentstatus",
            sendBy: "user",
            sendFrom:
            "${widget.appointmentDetails.pFirstName} ${widget.appointmentDetails.pLastName}",
            sendTo: "Admin");
        final notificationModelForAdmin = NotificationModel(
            title: "Canceled Appointment",
            body:
            "${widget.appointmentDetails.pFirstName} ${widget.appointmentDetails.pLastName} has canceled appointment for date ${widget.appointmentDetails.appointmentDate}. appointment id: ${widget.appointmentDetails.id}", //body
            uId: widget.appointmentDetails.uId,
            sendBy:
            "${widget.appointmentDetails.pFirstName} ${widget.appointmentDetails.pLastName}");
        await NotificationService.addData(notificationModel);
        _handleSendNotification();
        await NotificationService.addDataForAdmin(notificationModelForAdmin);
        ToastMsg.showToastMsg("Successfully Canceled");
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/Appointmentstatus', ModalRoute.withName('/'));
      } else {
        ToastMsg.showToastMsg("Something went wrong");
      }
    } else {
      ToastMsg.showToastMsg("Something went wrong");
    }
    setState(() {
      _isBtnDisable = "false";
      _isLoading = false;
    });
  }

  void _handleSendNotification() async {
    final res = await DrProfileService.getData();
    String _adminFCMid = res[0].fdmId;
    //send local notification

    await HandleLocalNotification.showNotification(
      "Canceled",
      "Appointment has been canceled for date ${widget.appointmentDetails.appointmentDate}", // body
    );
    await UpdateData.updateIsAnyNotification(
        "usersList", widget.appointmentDetails.uId, true);

    //send notification to admin app for booking confirmation
    await HandleFirebaseNotification.sendPushMessage(
        _adminFCMid, //admin fcm
        "Canceled Appointment", //title
        "${widget.appointmentDetails.pFirstName} ${widget.appointmentDetails.pLastName} has canceled appointment for date ${widget.appointmentDetails.appointmentDate}. appointment id: ${widget.appointmentDetails.id}" //body
    );
    await UpdateData.updateIsAnyNotification("profile", "profile", true);
  }

  _takeConfirmation() {
    DialogBoxes.confirmationBox(context, "Cancel",
        "Are you sure want to cancel appointment", _handleCancelBtn);
  }
}
