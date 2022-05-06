import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/style.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreServiceScreen extends StatefulWidget {
  final serviceDetails;

  const MoreServiceScreen({Key key, this.serviceDetails}) : super(key: key);
  @override
  _MoreServiceScreenState createState() => _MoreServiceScreenState();
}

class _MoreServiceScreenState extends State<MoreServiceScreen> {
  String launchUrl = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      launchUrl = widget.serviceDetails.url;
    });
    // print(widget.serviceDetails.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: widget.serviceDetails.url == ""
            ? null
            : BottomNavigationUrlWidget(
                title: "Book an appointment",
                onTap: () async {
                  print(launchUrl);
                  try {
                    await launch(launchUrl);
                  } catch (e) {
                    print(e);
                  }
                }),
        body: _buildContent());
  }

  Widget _buildContent() {
    return Stack(
      //overflow: Overflow.visible,
      children: <Widget>[
        CAppBarWidget(
          title: widget.serviceDetails.title,
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
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                  left: 20,
                  right: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCard(),
                      SizedBox(height: 20),
                      Text("Description", style: kPageTitleStyle),
                      SizedBox(height: 20),
                      Text(
                        widget.serviceDetails.desc,
                        style: kParaStyle,
                      ),
                    ],
                  ),
                )),
          ),
        )
      ],
    );
  }

  _buildCard() {
    return ListTile(
      contentPadding: const EdgeInsets.all(00.0),
      trailing:
          Icon(Icons.arrow_drop_down_outlined, size: 30, color: appBarColor),
      leading: CircleAvatar(
        backgroundColor: bgColor,
        radius: 30,
        child: ClipOval(
            child: Padding(
                padding: const EdgeInsets.all(00.0),
                child: widget.serviceDetails.imageUrl == ""
                    ? Icon(Icons.category_outlined, color: appBarColor)
                    : ImageBoxFillWidget(
                        imageUrl: widget.serviceDetails.imageUrl))),
      ),
      title: Text(widget.serviceDetails.title,
          style: TextStyle(
            fontFamily: 'OpenSans-Bold',
            fontSize: 14.0,
          )),
      subtitle: Text(widget.serviceDetails.subTitle,
          style: TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            fontSize: 14.0,
          )),
    );
  }
}
