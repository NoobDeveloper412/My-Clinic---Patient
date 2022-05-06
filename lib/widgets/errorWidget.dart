import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class IErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 300,
            child:
            //Container(color: Colors.red,)
            SvgPicture.asset(
                "assets/icon/error.svg",
                semanticsLabel: 'Acme Logo'
            ),
          ),
          SizedBox(height: 20),
          Text("Sorry it's error!",style: TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            fontSize: 14,
          )),
        ],
      ),
    );
  }
}
class NoInternetErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 300,
            child:
            //Container(color: Colors.red,)
            SvgPicture.asset(
                "assets/icon/error.svg",
                semanticsLabel: 'Acme Logo'
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text("No internet, please check your internet connection and try again!",style: TextStyle(
              fontFamily: 'OpenSans-SemiBold',
              fontSize: 14,
            )),
          ),
        ],
      ),
    );
  }
}
