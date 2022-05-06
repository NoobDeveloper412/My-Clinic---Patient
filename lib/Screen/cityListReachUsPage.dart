import 'package:demopatient/Screen/clinicListReachUsPage.dart';
import 'package:demopatient/Service/cityService.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';

class CityListReachUsPage extends StatefulWidget {
  @override
  _CityListReachUsPageState createState() => _CityListReachUsPageState();
}

class _CityListReachUsPageState extends State<CityListReachUsPage> {
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
            CAppBarWidget(title: "Select City"), //common app bar
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
                    CityService.getData(), //fetch images form database
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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: GridView.count(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: .9,
        crossAxisCount: 2,
        children: List.generate(listDetails.length, (index) {
          return _cardImg(listDetails[
          index]); //send type details and index with increment one
        }),
      ),
    );
  }

  _cardImg(listDetails) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClinicListReachUsPage(
              cityName: listDetails.title,
              cityId: listDetails.id,
            ),
          ),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 45,
                  child: listDetails.imageUrl==""||listDetails.imageUrl==null?Icon(Icons.image):ImageBoxFillWidget(imageUrl: listDetails.imageUrl)),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 45,
                    child: Center(
                      child: Text(
                        listDetails.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontFamily: "OpenSans-SemiBold"),
                      ),
                    ),
                  )),

            ],
          )),
    );
  }
}
