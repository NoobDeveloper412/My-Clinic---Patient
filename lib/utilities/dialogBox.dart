import 'package:demopatient/utilities/color.dart';
import 'package:flutter/material.dart';

class DialogBoxes {
  static Future<String> confirmationBox(
      context, String title, String subTitle, onPressed) {
    return showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: new Text(title),
          content: new Text(subTitle),
          actions: <Widget>[
            new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: btnColor,
                ),
                child: new Text("OK"),
                onPressed: () {
                  onPressed();
                  Navigator.of(context).pop();
                }),
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  static Future<String> stopBookingAlertBox(
      context, String title, String subTitle) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
            return null;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: new Text(title),
            content: new Text(subTitle),
          ),
        );
      },
    );
  }

  static Future<String> technicalIssueAlertBox(
      context, String title, String subTitle) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () {
            return null;
            //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: new Text(title),
            content: new Text(subTitle),
          ),
        );
      },
    );
  }

  static Future<String> versionUpdateBox(
      context, String title, String btnTitle, String subTitle, onPressed) {
    return showDialog(
      //barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: new Text(title),
          content: new Text(subTitle),
          actions: <Widget>[
            new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: btnColor,
                ),
                child: new Text(btnTitle),
                onPressed: () {
                  onPressed();
                  Navigator.of(context).pop();
                }),
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  static Future<String> forceUpdateBox(
      context, String title, String btnTitle, String subTitle, onPressed) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () {
            return null;
            //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: new Text(title),
            content: new Text(subTitle),
            actions: <Widget>[
              new ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: btnColor,
                  ),
                  child: new Text(btnTitle),
                  onPressed: () {
                    onPressed();
                  }),
              // usually buttons at the bottom of the dialog
            ],
          ),
        );
      },
    );
  }
}
