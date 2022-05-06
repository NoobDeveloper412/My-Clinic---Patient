import 'package:demopatient/Screen/aboutus.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/Service/drProfileService.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';

class AboutUsDoctorsListPage extends StatefulWidget {
  final cityName;
  final cityId;

  AboutUsDoctorsListPage({ this.cityId,this.cityName});
  @override
  _AboutUsDoctorsListPageState createState() => _AboutUsDoctorsListPageState();
}

class _AboutUsDoctorsListPageState extends State<AboutUsDoctorsListPage> {
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
            CAppBarWidget(title: widget.cityName), //common app bar
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: IBoxDecoration.upperBoxDecoration(),
                child: FutureBuilder(
                    future: DrProfileService.getDataByCityId(
                        widget.cityId), //fetch images form database
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
        childAspectRatio: .6,
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
            builder: (context) => AboutUs(
              doctId: listDetails.id,
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
                  bottom: 90,
                  child:listDetails.profileImageUrl==""||listDetails.profileImageUrl==null?Icon(Icons.image): ImageBoxFillWidget(
                      imageUrl: listDetails.profileImageUrl)),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 90,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dr. " +
                                listDetails.firstName +
                                " " +
                                listDetails.lastName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontFamily: "OpenSans-SemiBold"),
                          ),
                          Text(
                            listDetails.hName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontFamily: "OpenSans-SemiBold"),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
