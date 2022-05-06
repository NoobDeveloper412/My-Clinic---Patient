import 'package:demopatient/Service/availablityService.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:flutter/material.dart';

class AvailabilityPage extends StatefulWidget {
  AvailabilityPage({Key key}) : super(key: key);

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget(
        title: "Book an appointment",
        route: "/CityListPage",
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          CAppBarWidget(title: "Availability"),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: IBoxDecoration.upperBoxDecoration(),
              child: FutureBuilder(
                  future:
                      AvailabilityService.getAvailability(), //fetch all times
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return snapshot.data.length == 0
                          ? NoDataWidget()
                          : _buildContent(snapshot);
                    else if (snapshot.hasError)
                      return IErrorWidget(); //if any error then you can also use any other widget here
                    else
                      return LoadingIndicatorWidget();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Text("We are available on",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans-Bold',
                  fontSize: 15.0,
                ))),
        Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: buildTable(snapshot.data[0])),
      ],
    );
  }

  Widget buildTable(day) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          rowContent("Day", "Time"),
          Divider(),
          rowContent("Monday", "${day.mon}"),
          Divider(),
          rowContent("Tuesday", "${day.tue}"),
          Divider(),
          rowContent("Wednesday", "${day.wed}"),
          Divider(),
          rowContent("Thursday", "${day.thu}"),
          Divider(),
          rowContent("Friday", "${day.fri}"),
          Divider(),
          rowContent("Saturday", "${day.sat}"),
          Divider(),
          rowContent("Sunday", "${day.sun}"),
          Divider(),
        ],
      ),
    );
  }

  Widget rowContent(String first, String last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(first,
            style: TextStyle(
              fontFamily: 'OpenSans-SemiBold',
              fontSize: 14.0,
            )),
        Text(
          last,
          style: TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            fontSize: 14.0,
          ),
        )
      ],
    );
  }
}
