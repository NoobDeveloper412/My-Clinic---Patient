import 'package:demopatient/utilities/color.dart';
import 'package:flutter/material.dart';

class SmallButtonsWidget extends StatelessWidget {
  @required
  final String title;
  @required
  final onPressed;
  SmallButtonsWidget({this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        ),
        onPressed: onPressed,
        child: Text(title, style: TextStyle(fontSize: 14)));
  }
}

class RoundedBtnWidget extends StatelessWidget {
  @required
  final String title;
  @required
  final onPressed;
  RoundedBtnWidget({this.onPressed, this.title});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
