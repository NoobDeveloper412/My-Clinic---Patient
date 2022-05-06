import 'package:flutter/material.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/style.dart';

class Contactuspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact us", style: kAppbarTitleStyle),
        backgroundColor: appBarColor,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "if anu quries or any problem with our service then you can contact us with email: healthinari@gmail.com."),
          )
        ],
      ),
    );
  }
}
