import 'package:demopatient/SetData/screenArg.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/utilities/inputfields.dart';
import 'package:demopatient/utilities/toastMsg.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPatient extends StatefulWidget {
  RegisterPatient({Key key}) : super(key: key);

  @override
  _RegisterPatientState createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController _desController = TextEditingController();
  String _selectedGender = 'Gender';

  var _isBtnDisable = "false";

  @override
  void initState() {
    // TODO: implement initState
    _getAndSetData();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    ageController.dispose();
    _cityController.dispose();
    _desController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChooseTimeScrArg _chooseTimeScrArgs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
        bottomNavigationBar: BottomNavigationStateWidget(
          title: "Next",
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (_selectedGender == "Gender") {
                ToastMsg.showToastMsg("Please select gender");
              } else {
                Navigator.pushNamed(
                  context,
                  '/ConfirmationPage',
                  arguments: PatientDetailsArg(
                      _firstNameController.text,
                      _lastNameController.text,
                      _phoneNumberController.text,
                      _emailController.text,
                      ageController.text,
                      _selectedGender,
                      _cityController.text,
                      _desController.text,
                      _chooseTimeScrArgs.serviceName,
                      _chooseTimeScrArgs.serviceTimeMIn,
                      _chooseTimeScrArgs.selectedTime,
                      _chooseTimeScrArgs.selectedDate,
                      _chooseTimeScrArgs.doctName,
                      _chooseTimeScrArgs.deptName,
                      _chooseTimeScrArgs.hName,
                      _chooseTimeScrArgs.doctId,
                      _chooseTimeScrArgs.fee,
                  _chooseTimeScrArgs.deptId,
                  _chooseTimeScrArgs.cityId,
                  _chooseTimeScrArgs.clinicId,
                  _chooseTimeScrArgs.clinicName,
                  _chooseTimeScrArgs.cityName),
                );
              }
            }
          },
          clickable: _isBtnDisable,
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CAppBarWidget(title: "Register Patient"),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: IBoxDecoration.upperBoxDecoration(),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 15, right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InputFields.textInputFormField(
                            context,
                            "First Name*",
                            TextInputType.text,
                            _firstNameController,
                            1,
                            (item) {
                              return item.length > 0
                                  ? null
                                  : "Enter your first name";
                            },
                          ),
                          InputFields.textInputFormField(
                            context,
                            "Last Name*",
                            TextInputType.text,
                            _lastNameController,
                            1,
                            (item) {
                              return item.length > 0 ? null : "Enter last name";
                            },
                          ),
                          InputFields.textInputFormField(
                            context,
                            "Phone Number*",
                            TextInputType.number,
                            _phoneNumberController,
                            1,
                            (item) {
                              return item.length >8
                                  ? null
                                  : "Enter a valid Phone number ";
                            },
                          ),
                          InputFields.textInputFormField(
                            context,
                            "Email",
                            TextInputType.emailAddress,
                            _emailController,
                            1,
                            (item) {
                              Pattern pattern =
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?)*$";
                              RegExp regex = new RegExp(pattern);
                              if (item.length > 0) {
                                if (!regex.hasMatch(item) || item == null)
                                  return 'Enter a valid email address';
                                else
                                  return null;
                              } else
                                return null;
                            },
                          ),
                          InputFields.ageInputFormField(
                            context,
                            "Age*",
                            TextInputType.number,
                            ageController,
                            false,
                            (item) {
                              if (item.length > 0 && item.length <= 3)
                                return null;
                              else if (item.length > 3)
                                return "Enter valid age";
                              else
                                return "Enter age";
                            },
                          ),
                          Container(
                            width: double.infinity,
                            child: _genderDropDown(),
                          ),
                          InputFields.textInputFormField(
                            context,
                            "City*",
                            TextInputType.text,
                            _cityController,
                            1,
                            (item) {
                              return item.length > 0 ? null : "Enter city";
                            },
                          ),
                          InputFields.textInputFormField(
                            context,
                            "Description, About your Problem",
                            TextInputType.text,
                            _desController,
                            5,
                            (item) {
                              if (item.isEmpty)
                                return null;
                              else {
                                return item.length > 0
                                    ? null
                                    : "Enter Description";
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  _genderDropDown() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 0, right: 15),
      child: DropdownButton<String>(
        focusColor: Colors.white,
        value: _selectedGender,
        //elevation: 5,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: btnColor,
        items: <String>[
          'Gender',
          'Male',
          'Female',
          'Other',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        hint: Text(
          "Select Gender",
        ),
        onChanged: (String value) {
          setState(() {
            print(value);
            _selectedGender = value;
          });
        },
      ),
    );
  }

  void _getAndSetData() async{
    SharedPreferences _prefs=await SharedPreferences.getInstance();
    _firstNameController.text=_prefs.getString("firstName");
    _lastNameController.text=_prefs.getString("lastName");
    _phoneNumberController.text=_prefs.getString('phn').substring(3);
  }
}
