import 'package:demopatient/Service/Firebase/readData.dart';
import 'package:demopatient/Service/Noftification/handleFirebaseNotification.dart';
import 'package:demopatient/Service/Noftification/handleLocalNotification.dart';
import 'package:demopatient/Service/userService.dart';
import 'package:demopatient/utilities/dialogBox.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/Service/bannerService.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demopatient/widgets/drwaerWidgte.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _uPhn = "";
  String _uId = "";
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    // initialize local and firebase notification
    HandleLocalNotification.initializeFlutterNotification(
        context); //local notification
    HandleFirebaseNotification.handleNotifications(
        context); //firebase notification
    _getAndSetUserData(); //get users details from database
    _checkTechnicalIssueStatus(); //check show technical issue dialog box
    super.initState();
  }

  _getAndSetUserData() async {
    //start loading indicator
    setState(() {
      _isLoading = true;
    });
    // final res=await FirebaseMessaging.instance.getToken();
    // print(res);
    final user =await UserService.getData(); // get all user details from database
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //set all data
    setState(() {
      _uId = user[0].uId;
      _uPhn = user[0].pNo;
    });
    prefs.setString("firstName", user[0].firstName);
    prefs.setString("lastName", user[0].lastName);
    prefs.setString("uid", user[0].uId);
    prefs.setString("phn", user[0].pNo);
    prefs.setString("imageUrl", user[0].imageUrl);
    prefs.setString("createdDate", user[0].createdDate);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IDrawer(phoneNum: _uPhn),
      bottomNavigationBar:  BottomNavigationWidget(
                  title: "Book an appointment", route: "/CityListPage"),
      body: _isLoading
              ? LoadingIndicatorWidget()
              : Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    HAppBarWidget(
                      title: "My Clinic",
                      uId: _uId,
                    ),
                    // AppBars()
                    //     .homePageAppBar("My Clinic", _uPhn, _uName, _uId, context),
                    Positioned(
                      top: 80,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: IBoxDecoration.upperBoxDecoration(),
                        child: FutureBuilder(
                            future: BannerImageService
                                .getData(), //fetch banner image urls
                            builder: (context, snapshot) {
                              if (snapshot.hasData)
                                return snapshot.data.length == 0
                                    ? NoDataWidget()
                                    : _buildContent(snapshot.data[0]);
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

  Widget _table() {
    return Table(
      children: [
        TableRow(children: [
          _cardImg('assets/icon/doct.svg', 'Doctors', "/CityDRListPage"),
          _cardImg('assets/icon/teeth.svg', 'Services', "/ServicesPage"),
          _cardImg(
              "assets/icon/appoin.svg", "Appointment", '/Appointmentstatus')
        ]),
        TableRow(children: [
          _cardImg('assets/icon/reachus.svg', 'Reach Us', "/CityListReachUsPage"),
          // _notificationCardImg(
          //     'assets/icon/bell.svg', 'Notification', "/NotificationPage"),
          _cardImg("assets/icon/docblog.svg", "Health Blog", "/BlogPostPage"
              //    "/TestimonialsPage"
              ),
          _cardImg("assets/icon/gallery.svg", "Gallery", "/GalleryPage")
        ]),
        TableRow(children: [
          _cardImg('assets/icon/sch.svg', 'Availability', '/AvaliblityPage'),

          //Container()
          //_cardImg("assets/icon/call.svg", "Contact Us", "/ContactUsPage")
          _cardImg(
              "assets/icon/pres.svg", "Prescription", "/PrescriptionListPage"),
          _cardImg(
              "assets/icon/user.svg", "My Profile", "/EditUserProfilePage"),


        ]),
      ],
    );
  }

  Widget _cardImg(String path, String title, String routeName) {
    return GestureDetector(
      onTap: () async {
        //  Check.addData();
        if (routeName != null) {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .15,
        //width: MediaQuery.of(context).size.width * .1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Container(
              //     height: 50,
              //     width: 50,
              //     color: Colors.grey,
              //     child: //Center(child: Text("Your assets"))),
              //         //delete the just above code [child container ] and uncomment the below code and set your assets
              //      ),

              SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset(path, semanticsLabel: 'Acme Logo'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: kTitleStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _notificationCardImg(String path, String title, String routeName) {
  //   return GestureDetector(
  //     onTap: () {
  //       //  Check.addData();
  //       if (routeName != null) {
  //         Navigator.pushNamed(context, routeName);
  //       }
  //     },
  //     child: Container(
  //       height: MediaQuery.of(context).size.height * .15,
  //       //width: MediaQuery.of(context).size.width * .1,
  //       child: Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         elevation: 5.0,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             // Container(
  //             //     height: 50,
  //             //     width: 50,
  //             //     color: Colors.grey,
  //             //     child: //Center(child: Text("Your assets"))),
  //             //         //delete the just above code [child container ] and uncomment the below code and set your assets
  //             //      ),
  //
  //             _buildNotificationIcon(path),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 8.0),
  //               child: Text(
  //                 title,
  //                 style: kTitleStyle,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildNotificationIcon(path) {
  //   return StreamBuilder(
  //       stream: ReadData.fetchNotificationDotStatus(_uId),
  //       builder: (context, snapshot) {
  //         return !snapshot.hasData
  //             ? SizedBox(
  //                 height: 30,
  //                 width: 30,
  //                 child: SvgPicture.asset(path, semanticsLabel: 'Acme Logo'),
  //               )
  //             : Stack(
  //                 children: [
  //                   SizedBox(
  //                     height: 30,
  //                     width: 30,
  //                     child:
  //                         SvgPicture.asset(path, semanticsLabel: 'Acme Logo'),
  //                   ),
  //                   snapshot.data["isAnyNotification"]
  //                       ? Positioned(
  //                           top: 0,
  //                           right: 5,
  //                           child: CircleAvatar(
  //                             radius: 5,
  //                             backgroundColor: Colors.red,
  //                           ))
  //                       : Positioned(top: 0, right: 0, child: Container())
  //                 ],
  //               );
  //       });
  // }

  Widget _image(String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: ImageBoxFillWidget(imageUrl: imageUrl)),
    );
  }

  Widget _buildContent(bannerImages) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: Container(
                    color: Colors.grey,
                    child: ImageBoxFillWidget(
                      imageUrl: bannerImages.banner1,
                    ) //recommended 200*300 pixel
                    )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20, top: 8.0),
            child: Container(
              child: _table(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20, top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .45,
                    child: _image(
                        bannerImages.banner2) //recommended size 200*200 pixel
                    //_image('assets/images/offer2.jpg'),
                    ),
                Expanded(
                  child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * .45,
                      child: _image(
                          bannerImages.banner3) //recommended size 200*200 pixel
                      //_image('assets/images/offer3.jpeg'),
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 20.0, left: 20, top: 8.0, bottom: 20.0),
            child: Container(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width,
                child: _image(
                    bannerImages.banner4) //recommended size 200*400 pixel
                ),
          ),
        ],
      ),
    );
  }

  void _checkTechnicalIssueStatus() async {
    final res = await ReadData.fetchSettings(); //fetch settings details
    if (res != null) {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        // String appName = packageInfo.appName;
        // String packageName = packageInfo.packageName;
        String version = packageInfo.version;
        // String buildNumber = packageInfo.buildNumber;
        print(version);
        if (res["currentVersion"] != version) {
          if (!res["forceUpdate"]) {
            DialogBoxes.versionUpdateBox(context, "Update", "update",
                "New version is available, please update the app.", () async {
              final _url =
                  "https://play.google.com/store/apps/details?id=com.demo.demopatient";
              await canLaunch(_url)
                  ? await launch(_url)
                  : throw 'Could not launch $_url';
            });
          } else if (res["forceUpdate"]) {
            DialogBoxes.forceUpdateBox(context, "Update", "update",
                "Sorry we are currently not supporting the old version of the app please update with new version",
                () async {
              final _url =
                  "https://play.google.com/store/apps/details?id=com.demo.demopatient";
              await canLaunch(_url)
                  ? await launch(_url)
                  : throw 'Could not launch $_url';
            });
          }
        } else if (res["technicalIssue"]) {
          DialogBoxes.technicalIssueAlertBox(context, "Sorry!",
              "we are facing some technical issues. our team trying to solve problems. hope we will come back very soon.");
        }
      });
    }
  }
}
