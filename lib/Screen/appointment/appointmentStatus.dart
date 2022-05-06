import 'package:demopatient/Service/Firebase/readData.dart';
import 'package:demopatient/Service/appointmentService.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/Screen/appointment/appointmentDetailsPage.dart';

class AppointmentStatus extends StatefulWidget {
  AppointmentStatus({Key key}) : super(key: key);

  @override
  _AppointmentStatusState createState() => _AppointmentStatusState();
}

class _AppointmentStatusState extends State<AppointmentStatus> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          bottomNavigationBar: BottomNavigationWidget(
              title: "Book an appointment", route: '/CityListPage'),
          appBar: AppBar(
            title: Text("Appointments", style: kAppbarTitleStyle),
            centerTitle: true,
            backgroundColor: appBarColor,
            actions: [_appBarActionWidget()],
            bottom: TabBar(
              indicatorWeight: 3,
              indicatorColor: Colors.white,
              labelPadding: EdgeInsets.all(8),
              tabs: [
                Text(
                  "Upcoming",
                  style: kAppbarTitleStyle,
                ),
                Text(
                  "Past",
                  style: kAppbarTitleStyle,
                ),
              ],
            ),
          ),
          body: Container(
            child: TabBarView(
              children: [_upcomingAppointmentList(), _pastAppointmentList()],
            ),
          )),
    );
  }

  Widget _upcomingAppointmentList() {
    // <1> Use FutureBuilder
    return FutureBuilder(
        // <2> Pass `Future<QuerySnapshot>` to future
        future: AppointmentService.getData(
            "Pending,Confirmed,Rescheduled"), ////fetch appointment details according to uid
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData)
            return snapshot.data.length == 0
                ? NoBookingWidget()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return _card(snapshot.data, index);
                        }));
          else if (snapshot.hasError)
            return IErrorWidget(); //if any error then you can also use any other widget here
          else
            return LoadingIndicatorWidget();
        });
  }

  Widget _pastAppointmentList() {
    // <1> Use FutureBuilder
    return FutureBuilder(
        // <2> Pass `Future<QuerySnapshot>` to future
        future: AppointmentService.getData(
            "Visited,Rejected,Canceled"), //fetch appointment details according to uid
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData)
            return snapshot.data.length == 0
                ? NoDataWidget()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return _card(snapshot.data, index);
                        }));
          else if (snapshot.hasError)
            return IErrorWidget(); //if any error then you can also use any other widget here
          else
            return LoadingIndicatorWidget();
        });
  }

  Widget _card(appointmentDetails, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentDetailsPage(
                appointmentDetails: appointmentDetails[index]),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _appointmentDate(
                appointmentDetails[index].appointmentDate,
              ),
              // VerticalDivider(),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Text("Name: ",
                              style: TextStyle(
                                fontFamily: 'OpenSans-Regular',
                                fontSize: 12,
                              )),
                          Text(
                              appointmentDetails[index].pFirstName +
                                  " " +
                                  appointmentDetails[index].pLastName,
                              style: TextStyle(
                                fontFamily: 'OpenSans-SemiBold',
                                fontSize: 15,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Time: ",
                              style: TextStyle(
                                fontFamily: 'OpenSans-Regular',
                                fontSize: 12,
                              )),
                          Text(appointmentDetails[index].appointmentTime,
                              style: TextStyle(
                                fontFamily: 'OpenSans-SemiBold',
                                fontSize: 15,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  height: 1, color: Colors.grey[300])),
                          Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: appointmentDetails[index]
                                          .appointmentStatus ==
                                      "Pending"
                                  ? _statusIndicator(Colors.yellowAccent)
                                  : appointmentDetails[index]
                                              .appointmentStatus ==
                                          "Rescheduled"
                                      ? _statusIndicator(Colors.orangeAccent)
                                      : appointmentDetails[index]
                                                  .appointmentStatus ==
                                              "Rejected"
                                          ? _statusIndicator(Colors.red)
                                          : appointmentDetails[index]
                                                      .appointmentStatus ==
                                                  "Confirmed"
                                              ? _statusIndicator(Colors.green)
                                              : null),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                            child: Text(
                              appointmentDetails[index].appointmentStatus,
                              style: TextStyle(
                                fontFamily: 'OpenSans-Regular',
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(  appointmentDetails[index].clinicName +" "+appointmentDetails[index].cityName,
                          style: TextStyle(
                            fontFamily: 'OpenSans-Regular',
                            fontSize: 12,
                          )),
                      Text(appointmentDetails[index].serviceName,
                          style: TextStyle(
                            fontFamily: 'OpenSans-SemiBold',
                            fontSize: 15,
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _appointmentDate(date) {
    var appointmentDate = date.split("-");
    var appointmentMonth;
    switch (appointmentDate[0]) {
      case "1":
        appointmentMonth = "JAN";
        break;
      case "2":
        appointmentMonth = "FEB";
        break;
      case "3":
        appointmentMonth = "MARCH";
        break;
      case "4":
        appointmentMonth = "APRIL";
        break;
      case "5":
        appointmentMonth = "MAY";
        break;
      case "6":
        appointmentMonth = "JUN";
        break;
      case "7":
        appointmentMonth = "JULY";
        break;
      case "8":
        appointmentMonth = "AUG";
        break;
      case "9":
        appointmentMonth = "SEP";
        break;
      case "10":
        appointmentMonth = "OCT";
        break;
      case "11":
        appointmentMonth = "NOV";
        break;
      case "12":
        appointmentMonth = "DEC";
        break;
    }

    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(appointmentMonth,
            style: TextStyle(
              fontFamily: 'OpenSans-SemiBold',
              fontSize: 15,
            )),
        Text(appointmentDate[1],
            style: TextStyle(
              fontFamily: 'OpenSans-SemiBold',
              color: btnColor,
              fontSize: 35,
            )),
        Text(appointmentDate[2],
            style: TextStyle(
              fontFamily: 'OpenSans-SemiBold',
              fontSize: 15,
            )),
      ],
    );
  }

  Widget _statusIndicator(color) {
    return CircleAvatar(radius: 4, backgroundColor: color);
  }

  Widget _appBarActionWidget() {
    return StreamBuilder(
        stream: ReadData.fetchNotificationDotStatus(
            FirebaseAuth.instance.currentUser.uid),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Container()
              : IconButton(
                  icon: Stack(
                    children: [
                      Icon(Icons.notifications, color: appBarIconColor),
                      snapshot.data["isAnyNotification"]
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 5,
                              ),
                            )
                          : Positioned(top: 0, right: 0, child: Container())
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/NotificationPage",
                    );
                  }
                  //

                  );
        });
  }
}
