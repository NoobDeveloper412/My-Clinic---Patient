import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/curverdpath.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/widgets/callMsgWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/Service/drProfileService.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: DrProfileService
                .getData(), //fetch doctors profile details like name, profileImage, description etc
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return snapshot.data.length == 0
                    ? NoDataWidget()
                    : _buildContent(snapshot.data[0]); //main content
              else if (snapshot.hasError)
                return IErrorWidget(); //if any error then you can also use any other widget here
              else
                return LoadingIndicatorWidget();
            }));
  }

  Widget _buildContent(profile) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 240,
            // color: Colors.yellowAccent,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.red,
                  child: CustomPaint(
                    painter: CurvePainter(),
                  ),
                ),
                Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: appBarIconColor),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          " Dr Profile",
                          style: kAppbarTitleStyle,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.home,
                              color: appBarIconColor,
                            ),
                            onPressed: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                            })
                      ],
                    )),
                Positioned(
                  top: 80,
                  left: 25,
                  right: 25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: profile.profileImageUrl == ""
                                ? Icon(
                                    Icons.person,
                                    size: 50,
                                  )
                                : ImageBoxFillWidget(
                                    imageUrl: profile
                                        .profileImageUrl) //recommended image 200*200 pixel
                            ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                  "Dr ${profile.firstName} ${profile.lastName}",
                                  //doctors first name and last name
                                  style: TextStyle(
                                    color: Colors.black,
                                    //change colors form here
                                    fontFamily: 'OpenSans-Bold',
                                    // change font style from here
                                    fontSize: 15.0,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                  //"jhdsvdsh",
                                  profile.subTitle,
                                  //doctor subtitle
                                  style: TextStyle(
                                    color: Colors.black,
                                    //change colors form here
                                    fontFamily: 'OpenSans-Bold',
                                    // change font style from here
                                    fontSize: 15.0,
                                  )),
                            ),
                            CallMsgWidget(
                              primaryNo: profile.pNo1,
                              whatsAppNo: profile.whatsAppNo,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 10),
              child:
                  _callUsMailUsBox(profile.pNo1, profile.pNo2, profile.email)),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 25.0, right: 25),
            child: Text("Location", style: kPageTitleStyle),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .45,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/ReachUsPage');
                      },
                      child: Card(
                        elevation: 5.0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              'assets/images/map.png',
                              fit: BoxFit.fill,
                            ) //this is a asset image only not a google map integration

                            ),
                      ),
                    )),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.place, size: 20, color: Colors.grey),
                            Expanded(
                              child: Text(
                                "Behind Mohan Talkies Katni",
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today,
                                  size: 20, color: Colors.grey),
                              Text("Mon-Sat")
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.access_time,
                                  size: 20, color: Colors.grey),
                              Expanded(child: Text("11:00 - 3:00, 5:00 - 7:00"))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.phone, size: 20, color: Colors.grey),
                              Text(profile.pNo1)
                              //phone number of the doctor this dynamic
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _callUsMailUsBox(String phn, String phn2, String email) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width * .4,
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Call us", style: kPageTitleStyle),
                    Text(
                      "$phn\n$phn2",
                      style: TextStyle(
                        fontFamily: 'OpenSans-Regular',
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width * .4,
          child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Mail us", style: kPageTitleStyle),
                      Text(
                        email,
                        style: TextStyle(
                          fontFamily: 'OpenSans-Regular',
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        )
      ],
    );
  }
}
