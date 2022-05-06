import 'package:demopatient/Screen/departmentPage.dart';
import 'package:demopatient/Service/clinicService.dart';
import 'package:demopatient/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';

class ClinicListPage extends StatefulWidget {
  final cityId;
  final cityName;
  ClinicListPage({this.cityId,this.cityName});
  @override
  _ClinicListPageState createState() => _ClinicListPageState();
}

class _ClinicListPageState extends State<ClinicListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationStateWidget(
      //   title: "Next",
      //   onPressed: () {
      //
      //   },
      //   clickable: "true"//_serviceName,
      // ),
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CAppBarWidget(title: "Select Clinic"), //common app bar
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: IBoxDecoration.upperBoxDecoration(),
                child: FutureBuilder(
                    future:
                    ClinicService.getData(widget.cityId), //fetch images form database
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return snapshot.data.length == 0
                            ? NoDataWidget()
                            : _buildContent(snapshot.data);
                      else if (snapshot.hasError)
                        return IErrorWidget(); //if any error then you can also use any other widget here
                      else
                        return LoadingIndicatorWidget();
                    }),
              ),
            )
          ],
        ));
  }

  _buildContent(listDetails) {
    return ListView.builder(
      itemCount:listDetails.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
      return _cardImg(listDetails[index]);
    });

  }

  _cardImg(listDetails) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChooseDepartmentPage(
              cityId: widget.cityId,
              cityName:widget.cityName ,
              clinicId: listDetails.id,
              clinicName: listDetails.title,
              clinicLocationName: listDetails.locationName,
            ),
          ),
        );
      },
      child: Card(
        color: bgColor,
        elevation: .5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
               width: 100,
               child:   ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: listDetails.imageUrl==""||listDetails.imageUrl==null?Icon(Icons.image):ImageBoxFillWidget(imageUrl: listDetails.imageUrl))
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                listDetails.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14, fontFamily: "OpenSans-SemiBold"),
              ),
                  Text(
                    listDetails.locationName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, fontFamily: "OpenSans-SemiBold"),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
      // child: Card(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10.0),
      //     ),
      //     child: Stack(
      //       children: [
      //         Positioned(
      //             top: 0,
      //             left: 0,
      //             right: 0,
      //             bottom: 45,
      //             child: ImageBoxFillWidget(imageUrl: listDetails.imageUrl)),
      //         Positioned(
      //             bottom: 0,
      //             left: 0,
      //             right: 0,
      //             child: Container(
      //               height: 45,
      //               child: Center(
      //                 child: Text(
      //                   listDetails.title,
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                       fontSize: 14, fontFamily: "OpenSans-SemiBold"),
      //                 ),
      //               ),
      //             )),
      //       ],
      //     )),
    );
  }
}
