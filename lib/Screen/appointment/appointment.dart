import 'package:demopatient/Screen/appointment/choosetimeslots.dart';
import 'package:demopatient/Service/Firebase/readData.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/utilities/dialogBox.dart';

class AppointmentPage extends StatefulWidget {
  final doctId;
  final lunchOpTime;
  final lunchCloTime;
  final closingDate;
  final serviceTime;
  final dayCode;
  final copt;
  final cclt;
  final deptName;
  final doctName;
  final hospitalName;
  final stopBooking;
  final fee;
  final clinicId;
  final cityId;
  final deptId;
  final cityName;
  final clinicName;
  AppointmentPage(
      {Key key,
      this.doctId,
      this.lunchCloTime,
      this.lunchOpTime,
      this.closingDate,
      this.deptName,
      this.doctName,
      this.hospitalName,
      this.serviceTime,
      this.dayCode,
      this.cclt,
      this.copt,
      this.stopBooking,
      this.fee,this.cityId,this.clinicId,this.deptId,this.cityName,this.clinicName})
      : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  List appointmentTypesDetails = [
    {"title": "Online", "imageUrl": "assets/images/online.jpg"},
    {"title": "Offline", "imageUrl": "assets/images/offline.jpg"}
  ];
  bool _isLoading = false;
  void initState() {
    // TODO: implement initState

    _checkStopBookingStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: BottomNavigationStateWidget(
        //   title: "Next",
        //   onPressed: () {
        //
        //     // Navigator.pushNamed(context, "/ChooseTimeSlotPage",
        //     //     arguments: ServiceScrArg(_serviceName, _serviceTimeMin,_openingTime,_closingTime));
        //   },
        //   clickable: _serviceName,
        // ),
        body: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        CAppBarWidget(title: "Book an appointment"), //common app bar
        Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child:
                //_stopBooking?showDialogBox():
                _isLoading
                    ? Container(
                        decoration: IBoxDecoration.upperBoxDecoration(),
                        height: MediaQuery.of(context).size.height,
                        child: LoadingIndicatorWidget())
                    : _buildContent()),
      ],
    ));
  }

  Widget _buildContent() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: IBoxDecoration.upperBoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20, right: 10),
                child: Center(
                    child: Text("What type of appointment",
                        style: kPageTitleStyle))),
            _buildGridView(appointmentTypesDetails),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView(appointmentTypesDetails) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: GridView.count(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: .9,
        crossAxisCount: 2,
        children: List.generate(appointmentTypesDetails.length, (index) {
          return _cardImg(appointmentTypesDetails[index],
              index + 1); //send type details and index with increment one
        }),
      ),
    );
  }

  Widget _cardImg(
    appointmentTypesDetails,
    num num,
  ) {
    //  print(appointmentTypesDetails.day);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChooseTimeSlotPage(
                serviceName: appointmentTypesDetails["title"],
                serviceTimeMin: int.parse(widget.serviceTime),
                openingTime: widget.copt,
                closingTime: widget.cclt,
                closedDay: widget.dayCode,
                lunchOpTime: widget.lunchOpTime,
                lunchCloTime: widget.lunchCloTime,
                drClosingDate: widget.closingDate,
                doctName: widget.doctName,
                hospitalName: widget.hospitalName,
                deptName: widget.deptName,
                doctId: widget.doctId,
                stopBooking: widget.stopBooking,
                fee: widget.fee,
              clinicId:widget.clinicId ,
              cityId:widget.cityId ,
              deptId:widget.deptId ,
              cityName: widget.cityName,
              clinicName:widget.clinicName ,

            ),
          ),
        );
      },
      child: Container(
        //  height: MediaQuery.of(context).size.height * .2,
        // width:  MediaQuery.of(context).size.width*.15,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          child: Stack(
            clipBehavior: Clip.none,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 40,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.asset(
                      appointmentTypesDetails['imageUrl'],
                      fit: BoxFit.fill,
                    ) //get images
                    ),
              ),
              Positioned.fill(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        color: btnColor,
                        child: Center(
                          child: Text(appointmentTypesDetails["title"],
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans-Bold',
                                fontSize: 12.0,
                              )),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  void _checkStopBookingStatus() async {
    setState(() {
      _isLoading = true;
    });
    print("LLLLLLLLLLLLLLLLLLLLL${widget.stopBooking}");
    final res = await ReadData.fetchSettings(); //fetch settings details
    if (res != null) if (res["stopBooking"])
      DialogBoxes.stopBookingAlertBox(context, "Sorry!",
          "We are currently not accepting new appointments. we will start soon");
    else if (widget.stopBooking == "true")
      DialogBoxes.stopBookingAlertBox(context, "Sorry!",
          "Dr ${widget.doctName} is not accepting new appointments");
    setState(() {
      _isLoading = false;
    });
  }
}
