import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReachUS extends StatefulWidget {
  ReachUS({Key key}) : super(key: key);

  @override
  _ReachUSState createState() => _ReachUSState();
}

class _ReachUSState extends State<ReachUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          CAppBarWidget(title: "Reach us"),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: IBoxDecoration.upperBoxDecoration(),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    // child: Container(
                    //     color: Colors.grey,
                    //     child: Center(child: Text("Your asset"))),
                    //delete the just above code [ child container ] and uncomment the below code and set your assets
                    child: Image.asset(
                      'assets/images/map3.jpg',
                      fit: BoxFit.cover,
                    ))),
          ),
          Positioned(
            bottom: -4,
            left: 5,
            right: 5,
            child: Container(
                height: 160,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "We are here...",
                          style: kPageTitleStyle,
                        ),
                    Text("In front of railway station, Panjab road chandigarh 429115",
                        style: TextStyle(
                          fontFamily: 'OpenSans-SemiBold',
                          fontSize: 12.0,
                        )),
                    ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: btnColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            child: Center(
                                child: Text("Contact Us",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/ContactUsPage');
                            })
                      ],
                    ),
                  ),
                )),
          ),
          Positioned(
            right: 25,
            bottom: 125,
            child: GestureDetector(
              onTap: () async {
                //take clinic longitude from google map
                final _url =
                    'https://www.google.com/maps/place//data=!4m2!3m1!1s0x398161db12ff7b09:0x70949117d57a65bf?utm_source=mstt_1&entry=gps&lucs=swa';
                try {
                  await launch(_url);
                } catch (e) {
                  print(e);
                }
              },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: btnColor,
                child: Icon(
                  Icons.near_me,
                  color: appBarIconColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
