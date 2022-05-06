
import 'package:demopatient/Service/AuthService/authservice.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/toastMsg.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class IDrawer extends StatefulWidget {
  final String phoneNum;
  IDrawer({this.phoneNum});
  @override
  _IDrawerState createState() => _IDrawerState();
}

class _IDrawerState extends State<IDrawer> {
  String _uName = "";
  String _imageUrl = "";
  @override
  void initState() {
    // TODO: implement initState
    _setUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      height: MediaQuery.of(context).size.height,
      color: bgColor,
      child: Column(
        children: [
          Container(
            color: appBarColor,
            height: 40,
          ),
          Container(color: appBarColor, child: _profileListTiles()),
          Container(
            color: appBarColor,
            height: 20,
          ),
          // Divider(),
          _iButton(
              "Profile",
              Icon(
                Icons.person,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/EditUserProfilePage");
          }),
          _divider(),
          _iButton(
              "Prescriptions ",
              Icon(
                Icons.file_copy,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/PrescriptionListPage");
          }),
          _divider(),
          _iButton(
              "Testimonials ",
              Icon(
                Icons.assignment,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/TestimonialsPage");
          }),
          _divider(),
          _iButton(
              "Feedback",
              Icon(
                Icons.feedback,
                color: iconsColor,
              ), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/FeedBackPage");
          }),
          _divider(),
          _iButton("Share the app", Icon(Icons.share, color: iconsColor), () {
            Navigator.pop(context);
            Share.share(
                'check out this app https://play.google.com/store/apps/details?id=com.demo.demopatient',
                subject: "Look that's very helpful!");
          }),
          _divider(),
          _iButton(
              "Rate us",
              Icon(
                Icons.star,
                color: iconsColor,
              ), () async {
            Navigator.pop(context);
            final _url =
                "https://play.google.com/store/apps/details?id=com.demo.demopatient"; //remember country code
            await canLaunch(_url)
                ? await launch(_url)
                : throw 'Could not launch $_url';
          }),
          _divider(),
          _iButton(
              "Log Out",
              Icon(
                Icons.logout,
                color: iconsColor,
              ),
              _handleSignOut),
          // _divider(),
          // _iButton(
          //     "Privacy Policy ",
          //     Icon(
          //       Icons.file_copy,
          //       color: iconsColor,
          //     ), () {
          //   Navigator.pop(context);
          //   Navigator.pushNamed(context, "/PrivacyPage");
          // }),
          // _iButton(
          //     "Refund Policy ",
          //     Icon(
          //       Icons.file_copy,
          //       color: iconsColor,
          //     ), () {
          //   Navigator.pop(context);
          //   Navigator.pushNamed(context, "/RefundPolicyPage");
          // }),
          // _iButton(
          //     "Contact us",
          //     Icon(
          //       Icons.file_copy,
          //       color: iconsColor,
          //     ), () {
          //   Navigator.pop(context);
          //   Navigator.pushNamed(context, "/Contactuspage");
          // }),

          _divider(),
          Expanded(
            child: Container(
                // color: Colors.red,
                child: Align(
                    alignment: Alignment.bottomCenter, child: _profileSvg())),
          )
          // _enquireBtn()
        ],
      ),
    ));
  }

  Widget _iButton(String titleText, Icon icon, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: icon,
        title: Text(
          titleText,
          style: TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  _profileListTiles() {
    return Row(
      children: [
        SizedBox(width: 20),
        _profileImage(),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_uName,
                  style: TextStyle(
                      fontFamily: 'OpenSans-Bold',
                      fontSize: 18,
                      color: Colors.white)),
              Text(
                widget.phoneNum,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        //subtitle: Text(widget.phoneNum),
      ],
    );
  }

  _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Divider(),
    );
  }

  void _setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _uName = prefs.getString("firstName") + " " + prefs.getString("lastName");
      _imageUrl = prefs.getString("imageUrl");
    });
  }

  _profileSvg() {
    return SizedBox(
      height: 300,
      width: 300,
      child:
          //Container(color: Colors.red,)
          SvgPicture.asset("assets/icon/editProfile.svg",
              semanticsLabel: 'Acme Logo'),
    );
  }

  Widget _profileImage() {
    return Container(
      //  color: Colors.green,
      child: ClipOval(
          child: _imageUrl == ""
              ? Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                )
              : SizedBox(
                  height: 80,
                  width: 80,
                  child: ImageBoxFillWidget(imageUrl: _imageUrl))),
    );

    //   ClipRRect(
    //     borderRadius: //BorderRadius.circular(8.0),
    //     child:  Image.network( )
    // );
  }

  static _handleSignOut() async {
    bool isSignOut = await AuthService.signOut();
    if (isSignOut) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      ToastMsg.showToastMsg("Logged Out");
    }
  }
}
