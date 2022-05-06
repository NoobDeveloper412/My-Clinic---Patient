import 'package:demopatient/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallMsgWidget extends StatelessWidget {
  @required
  final String primaryNo;
  @required
  final String whatsAppNo;
  @required
  final String email;

  CallMsgWidget({this.primaryNo, this.whatsAppNo, this.email});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _cardChatIcon(primaryNo),
        // _cardCallIcon(primaryNo),
        _cardEmailIcon(this.email),
        _cardWhatsAppIcon(whatsAppNo),
      ],
    );
  }

  Widget _cardEmailIcon(email) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: () {
          launch("mailto:$email"); //remember country code
        },
        child: Container(
          height:
              60, //MediaQuery.of(context).size.height * .08, you can also use media query here
          width: 60, //MediaQuery.of(context).size.width * .15,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: callBgkColor,
            child: Icon(Icons.email,
                color:
                    callIconColor), //you can change the color of icon form utilises/color.dart page
          ),
        ),
      ),
    );
  }

  // Widget _cardCallIcon(phn) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8.0),
  //     child: GestureDetector(
  //       onTap: () {
  //         launch("tel:$phn}"); //remember country code
  //       },
  //       child: Container(
  //         height:
  //             60, //MediaQuery.of(context).size.height * .08, you can also use media query here
  //         width: 60, //MediaQuery.of(context).size.width * .15,
  //         child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(5.0),
  //           ),
  //           color: callBgkColor,
  //           child: Icon(Icons.local_phone,
  //               color:
  //                   callIconColor), //you can change the color of icon form utilises/color.dart page
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _cardWhatsAppIcon(phn) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: () async {
          final _url =
              "https://wa.me/$phn?text=Hello Dr"; //remember country code
          await canLaunch(_url)
              ? await launch(_url)
              : throw 'Could not launch $_url';
        },
        child: Container(
          height:
              60, //MediaQuery.of(context).size.height * .08, you can also use media query
          width: 60, //MediaQuery.of(context).size.width * .15,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: videoBgkColor,
            child: Image.asset(
                "assets/icon/whatsapp.png"), //you can change the color of icon form utilises/color.dart page
          ),
        ),
      ),
    );
  }

  Widget _cardChatIcon(phn) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: () {
          launch("sms:$phn"); //remember country code
        },
        child: Container(
          height:
              60, //MediaQuery.of(context).size.height * .08, //you can also use here media query
          width: 60, //MediaQuery.of(context).size.width * .15,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: chatBgColor,
            child: Icon(Icons.chat_bubble,
                color:
                    chatIconColor), //you can change the color of icon form utilises/color.dart page
          ),
        ),
      ),
    );
  }
}
