import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:demopatient/utilities/color.dart';



class Meeting extends StatefulWidget {
  final uid;
  final doctid;
  final email;
  Meeting({this.uid,this.email,this.doctid});
  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  String roomText ="";//= TextEditingController(text: "plugintestroom");
  String subjectText="Meet With Doctor";//= TextEditingController(text: "My Plugin Test Meeting");
  String nameText = "";//TextEditingController(text: "Plugin Test User");
  String emailText ="";//= TextEditingController(text: "fake@email.com");
  String iosAppBarRGBAColor ="#0080FF80";
  //TextEditingController(text: "#0080FF80"); //transparent blue
  bool isAudioOnly = true;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    roomText= "quvtiopxzphaadkjfbajjknjasdfjbasdf${widget.uid}${widget.doctid}";
    nameText="Meet with doctor";
    emailText=widget.email;
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return
      Scaffold(
        appBar: AppBar(
          title: const Text('Join Video Call',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans-Bold',
            fontSize: 15.0,
          )),
          backgroundColor: appBarColor,
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: kIsWeb
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.30,
                child: meetConfig(),
              ),
              Container(
                  width: width * 0.60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        color: Colors.white54,
                        child: SizedBox(
                          width: width * 0.60 * 0.70,
                          height: width * 0.60 * 0.70,
                          child: JitsiMeetConferencing(
                            extraJS: [
                              // extraJs setup example
                              '<script>function echo(){console.log("echo!!!")};</script>',
                              '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                            ],
                          ),
                        )),
                  ))
            ],
          )
              : meetConfig(),
        ),
      );
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // SizedBox(
          //   height: 16.0,
          // ),
          // TextField(
          //   controller: serverText,
          //   decoration: InputDecoration(
          //       border: OutlineInputBorder(),
          //       labelText: "Server URL",
          //       hintText: "Hint: Leave empty for meet.jitsi.si"),
          // ),
          SizedBox(
            height: 100.0,
          ),

          // CheckboxListTile(
          //   title: Text("Audio Only"),
          //   value: isAudioOnly,
          //   onChanged: _onAudioOnlyChanged,
          // ),
          // SizedBox(
          //   height: 14.0,
          // ),
          // CheckboxListTile(
          //   title: Text("Audio Muted"),
          //   value: isAudioMuted,
          //   onChanged: _onAudioMutedChanged,
          // ),
          // SizedBox(
          //   height: 14.0,
          // ),
          // CheckboxListTile(
          //   title: Text("Video Muted"),
          //   value: isVideoMuted,
          //   onChanged: _onVideoMutedChanged,
          // ),
          // Divider(
          //   height: 48.0,
          //   thickness: 2.0,
          // ),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                _joinMeeting();
              },
              child: Text(
                "Join Meeting",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.green)),
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
        ],
      ),
    );
  }

  // _onAudioOnlyChanged(bool value) {
  //   setState(() {
  //     isAudioOnly = value;
  //   });
  // }

  // _onAudioMutedChanged(bool value) {
  //   setState(() {
  //     isAudioMuted = value;
  //   });
  // }
  //
  // _onVideoMutedChanged(bool value) {
  //   setState(() {
  //     isVideoMuted = value;
  //   });
  // }

  _joinMeeting() async {
    String serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: roomText)
      ..serverURL = serverUrl
      ..subject = subjectText
      ..userDisplayName = nameText
      ..userEmail = emailText
      ..iosAppBarRGBAColor = iosAppBarRGBAColor
      ..audioOnly = true//isAudioOnly
      ..audioMuted = true//isAudioMuted
      ..videoMuted =true// isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}