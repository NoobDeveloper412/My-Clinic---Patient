import 'package:demopatient/Service/drProfileService.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/curverdpath.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:demopatient/widgets/callMsgWidget.dart';

class AboutUs extends StatefulWidget {
  final doctId;
  AboutUs({Key key,this.doctId}) : super(key: key);
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                .getDataByDrId(widget.doctId), //fetch doctors profile details like name, profileImage, description etc
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return snapshot.data.length == 0
                    ? NoDataWidget()
                    : _buildContent(snapshot.data[0]);
              else if (snapshot.hasError)
                return IErrorWidget(); //if any error then you can also use any other widget here
              else
                return LoadingIndicatorWidget(); //loading page
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
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: appBarIconColor,
                          ),
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
                            child:
                            profile.profileImageUrl == ""
                                ?  Image.asset("assets/icon/dprofile.png")
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
                              child: Text("Contact us",
                                  //   "Dr ${profile.firstName} ${profile.lastName}",
                                  //doctors first name and last name
                                  style: TextStyle(
                                    color: Colors.black,
                                    //change colors form here
                                    fontFamily: 'OpenSans-Bold',
                                    // change font style from here
                                    fontSize: 15.0,
                                  )),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 15.0),
                            //   child: Text("",
                            //       //"jhdsvdsh",
                            //      // profile.subTitle,
                            //       //doctor subtitle
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //         //change colors form here
                            //         fontFamily: 'OpenSans-Bold',
                            //         // change font style from here
                            //         fontSize: 15.0,
                            //       )),
                            // ),
                            CallMsgWidget(
                              primaryNo: profile.pNo1,
                              whatsAppNo: profile.whatsAppNo,
                              email: profile.email,
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
          // Padding(
          //   padding: const EdgeInsets.only(left: 25.0, right: 25, top: 10),
          //   child: Text(profile.description,
          //       //description of doctor profile
          //       style: kParaStyle),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 25.0, right: 25),
            child: Text("About Us", style: kPageTitleStyle),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 8.0),
              child: Text(
                profile.aboutUs,
                style: kParaStyle,
              ))
        ],
      ),
    ));
  }
}
