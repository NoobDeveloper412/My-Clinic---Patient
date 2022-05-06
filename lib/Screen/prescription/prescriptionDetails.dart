import 'package:demopatient/Screen/showPrescriptionImae.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/utilities/inputfields.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:flutter/material.dart';

class PrescriptionDetailsPage extends StatefulWidget {
  final title;
  final prescriptionDetails;
  PrescriptionDetailsPage(
      {@required this.title, @required this.prescriptionDetails});
  @override
  _PrescriptionDetailsPageState createState() =>
      _PrescriptionDetailsPageState();
}

class _PrescriptionDetailsPageState extends State<PrescriptionDetailsPage> {
  TextEditingController _serviceNameController = new TextEditingController();
  TextEditingController _patientNameController = new TextEditingController();
  TextEditingController _drNameController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  TextEditingController _messageController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  List _imageUrls = [];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _serviceNameController.text = widget.prescriptionDetails.appointmentName;
      _patientNameController.text = widget.prescriptionDetails.patientName;
      _drNameController.text = widget.prescriptionDetails.drName;
      _dateController.text = widget.prescriptionDetails.appointmentDate;
      _timeController.text = widget.prescriptionDetails.appointmentTime;
      _messageController.text = widget.prescriptionDetails.prescription;
      if (widget.prescriptionDetails.imageUrl != "")
        _imageUrls = widget.prescriptionDetails.imageUrl.toString().split(",");
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _serviceNameController..dispose();
    _patientNameController.dispose();
    _drNameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          CAppBarWidget(title: widget.title),
          Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: IBoxDecoration.upperBoxDecoration(),
                child: ListView(
                  children: [
                    InputFields.readableInputField(
                        _serviceNameController, "Service", 1),
                    InputFields.readableInputField(
                        _patientNameController, "Name", 1),
                    InputFields.readableInputField(
                        _drNameController, "Dr Name", 1),
                    InputFields.readableInputField(_dateController, "Date", 1),
                    InputFields.readableInputField(_timeController, "Time", 1),
                    InputFields.readableInputField(
                        _messageController, "Message", null),
                    _buildImageList()
                  ],
                ),
              )),
        ],
      ),
    );
  }

  _buildImageList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: _imageUrls.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowPrescriptionImagePage(
                          imageUrls: _imageUrls,
                          selectedImagesIndex: index,
                          title: "Download Prescription"),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ImageBoxContainWidget(
                    imageUrl: _imageUrls[index],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
