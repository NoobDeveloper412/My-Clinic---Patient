import 'package:demopatient/Service/Firebase/updateData.dart';
import 'package:demopatient/Service/Noftification/handleFirebaseNotification.dart';
import 'package:demopatient/Service/drProfileService.dart';
import 'package:demopatient/Service/feedbackservice.dart';
import 'package:demopatient/Service/notificationService.dart';
import 'package:demopatient/model/feedbackmodel.dart';
import 'package:demopatient/model/notificationModel.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/utilities/inputfields.dart';
import 'package:demopatient/utilities/toastMsg.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  bool _isLoading=false;
  List feedbackText=[];
  String _adminFCMid="";
  List<bool> check=[
    false,false,false,false,false,false,false,false,false,false
  ];
  List <String> title=[
  "Introduction/achievements/Journey so far.",
  "Basic information about clinic/hospital/set up.",
  "Patient can contact through whatsapp",
  "Google map (patient can reach your location)",
  "Social media page (Facebook page, instagram,you tube,twitter)",
  "Patients can read content related to your specialisation/practice.",
  "Successful patient stories Own digital video call platform.",
  "It can easily be operated by your receptionist/staff.",
  "Own digital video call platform",
  "Forms(patient can send query to you)"
  ];

  TextEditingController _textEditingController=new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _setAdminFcmId();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationStateWidget(
        title: "Submit",
        onPressed: _isLoading?null:(){
          if(_textEditingController.text!=""&&_textEditingController!=null)
            feedbackText.add(_textEditingController.text);
          for(int i=0;i<check.length;i++){

            if(check[i])
              feedbackText.add(title[i]);

          }
          String submitText=feedbackText.join("*-*-##*-+");
          if(submitText==""||submitText==null){
                ToastMsg.showToastMsg("Please enter a feedback");

          }else   _handleSubmit(submitText);


        },
        clickable: "true",
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          CAppBarWidget(title: "Feedback"), //common app bar
          Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child:
              //_stopBooking?showDialogBox():
              Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: IBoxDecoration.upperBoxDecoration(),
                  child:_isLoading?LoadingIndicatorWidget(): _buildContent())),
        ],
      ),
    );
  }
  _buildContent(){
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("According to you which features are really essential to have a digital presence on Internet these days?",
          style: TextStyle(
            fontFamily: "OpenSans-SemiBold",
            fontSize: 14
          ),),
        ),
        Divider(),
        ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context,index){
              return  _buildCheckBox(index,title[index]);
            }
        ),
        InputFields.commonInputField(_textEditingController, "Enter Feedback", (item){
          return null;
        }, TextInputType.text, null)
      ],

    );

  }
  _buildCheckBox(index,text){
    // print(check);
    // print(text);
  return  Row(
      children: [
        Checkbox(
          value: check[index],
          onChanged: (bool value) {
            setState(() {
              check[index] = value;
              print(check);
            });
          },
        ),
        Flexible(child: Text(text,style: TextStyle(
            fontFamily:"OpenSans-SemiBold",
            fontSize: 15
        ),)),
      ],
    );
  }

  void _handleSubmit(submitText) async{
    setState(() {
      _isLoading=true;
    });

    SharedPreferences _prefs=await  SharedPreferences.getInstance();
    FeedbackModel feedbackModel=FeedbackModel(
      uid: _prefs.getString("uid"),
      name:_prefs.getString("firstName")+" "+_prefs.getString("lastName"),
      phn:_prefs.getString("phn") ,
      feedbacktext: submitText
    );
    final res=await FeedbackService.addData(feedbackModel);
    if(res=="success"){

      final notificationModelForAdmin = NotificationModel(
          title: "New Feedback",
          body:"New feedback received from ${_prefs.getString("firstName")+" "+_prefs.getString("lastName")}",
          uId: _prefs.getString("uid"),
          sendBy: _prefs.getString("firstName")+" "+_prefs.getString("lastName"),);

      final msgAdded = await NotificationService.addDataForAdmin(notificationModelForAdmin);
      print(msgAdded);
      if (msgAdded == "success") {

        _handleSendNotification(_prefs.getString("firstName"), _prefs.getString("lastName"));
      }
      ToastMsg.showToastMsg("Successfully submitted");
      for(int i=0;i<check.length;i++){
        setState(() {
          check[i]=false;
        });
      }
      setState(() {
        feedbackText.clear();
        _textEditingController.clear();
        _isLoading=false;
      });

    }
    else {
      ToastMsg.showToastMsg("Something went wrong");
    }

    setState(() {
      _isLoading=false;
    });

  }
  void _setAdminFcmId() async {
    //loading if data till data fetched
    setState(() {
      _isLoading = true;
    });
    final res = await DrProfileService
        .getData(); //fetch admin fcm id for sending messages to admin
    if (res != null) {
      setState(() {
        _adminFCMid = res[0].fdmId;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }
  void _handleSendNotification(String firstName, String lastName) async {
    //send local notification

    await HandleFirebaseNotification.sendPushMessage(
        _adminFCMid, //admin fcm
        "New Feedback", //title
        "New feedback received from$firstName $lastName" //body
    );

    await UpdateData.updateIsAnyNotification("profile", "profile", true);
  }
}
