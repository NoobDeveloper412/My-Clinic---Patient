import 'package:demopatient/utilities/color.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  @required
  final String title;
  @required
  final String route;
  BottomNavigationWidget({this.title, this.route});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 8.0, bottom: 8.0),
        child: SizedBox(
          height: 35,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: btnColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              child: Center(
                  child: Text(title,
                      style: TextStyle(
                        color: Colors.white,
                      ))),
              onPressed: () {
                Navigator.pushNamed(context, route);
              }),
        ),
      ),
    );
  }
}

class BottomNavigationUrlWidget extends StatelessWidget {
  @required
  final String title;
  @required
  final onTap;
  BottomNavigationUrlWidget({this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 8.0, bottom: 8.0),
        child: SizedBox(
          height: 35,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              child: Center(
                  child: Text(title,
                      style: TextStyle(
                        color: Colors.white,
                      ))),
              onPressed: onTap),
        ),
      ),
    );
  }
}

class BottomNavigationStateWidget extends StatelessWidget {
  @required
  final String title;
  @required
  final String clickable;
  @required
  final onPressed;
  BottomNavigationStateWidget({this.title, this.onPressed, this.clickable});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20, top: 8.0, bottom: 8.0),
          child: SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: btnColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                child: Center(
                    child: Text(title,
                        style: TextStyle(
                          color: Colors.white,
                        ))),
                onPressed: clickable == "" ? null : onPressed),
          ),
        ));
  }
}
