import 'package:demopatient/Service/Firebase/updateData.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/Service/notificationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isLoading = false;
  int _limit = 20;
  int _itemLength = 0;
  String _userCreatedDat = "";
  ScrollController _scrollController = new ScrollController();
  @override
  @override
  void initState() {
    // TODO: implement initState
    _scrollListener();
    _setRedDot();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget(
          route: "/CityListPage", title: "Book an appointment"),
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: Text(
              "Notification",
              style: kAppbarTitleStyle,
            ),
            centerTitle: true,
            backgroundColor: appBarColor,
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: IBoxDecoration.upperBoxDecoration(),
              child: _isLoading
                  ? LoadingIndicatorWidget()
                  : FutureBuilder(
                      future:
                          NotificationService.getData(_limit, _userCreatedDat),
                      //ReadData.fetchNotification(FirebaseAuth.instance.currentUser.uid),//fetch all times
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return snapshot.data.length == 0
                              ? NoDataWidget()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, left: 8, right: 8),
                                  child: _buildCard(snapshot.data));
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

  Widget _buildCard(notificationDetails) {
    _itemLength = notificationDetails.length;
    return ListView.builder(
        controller: _scrollController,
        itemCount: notificationDetails.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (notificationDetails[index].routeTo != "/NotificationPage" &&
                  notificationDetails[index].routeTo != "")
                Navigator.pushNamed(
                    context, notificationDetails[index].routeTo);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                    title: Text(
                      notificationDetails[index].title,
                      style: TextStyle(
                        fontFamily: 'OpenSans-Bold',
                        fontSize: 14.0,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${notificationDetails[index].body}",
                          style: TextStyle(
                            fontFamily: 'OpenSans-SemiBold',
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${notificationDetails[index].createdTimeStamp}",
                          style: TextStyle(
                            fontFamily: 'OpenSans-Regular',
                            fontSize: 10,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        });
  }

  void _setRedDot() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userCreatedDat = prefs.getString("createdDate");
    });

    await UpdateData.updateIsAnyNotification(
        "usersList", FirebaseAuth.instance.currentUser.uid, false);
    setState(() {
      _isLoading = false;
    });
  }

  void _scrollListener() {
    _scrollController.addListener(() {
      // print("blength $_itemLength $_limit");
      // print("length $_itemLength $_limit");
      if (_itemLength >= _limit) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _limit += 20;
          });
        }
      }
      // print(_scrollController.offset);
    });
  }
}
