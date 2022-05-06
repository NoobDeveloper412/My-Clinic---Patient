import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/utilities/decoration.dart';
import 'package:demopatient/widgets/bottomNavigationBarWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/Service/serviceService.dart';
import 'package:demopatient/Screen/moreService.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/buttonsWidget.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({Key key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationWidget(
          title: "Book an appointment",
          route: '/CityListPage',
        ),
        body: _buildContent());
  }

  Widget _buildContent() {
    return Stack(
      //overflow: Overflow.visible,
      children: <Widget>[
        CAppBarWidget(title: 'Service'),
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: IBoxDecoration.upperBoxDecoration(),
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                  left: 20,
                  right: 20,
                ),
                child: FutureBuilder(
                    future: ServiceService.getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return snapshot.data.length == 0
                            ? NoDataWidget()
                            : _buildGridView(snapshot.data);
                      else if (snapshot.hasError)
                        return IErrorWidget(); //if any error then you can also use any other widget here
                      else
                        return LoadingIndicatorWidget();
                    })),
          ),
        ),
      ],
    );
  }

  Widget _buildGridView(service) {
    return GridView.count(
      childAspectRatio: .8, //you can change the size of items
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(service.length, (index) {
        return _cardImg(service[index]);
      }),
    );
  }

  Widget _cardImg(serviceDetails) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              // color: Colors.yellowAccent,
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              top: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35,
                      child: ClipOval(
                          child: Padding(
                              padding: const EdgeInsets.all(00.0),
                              child: serviceDetails.imageUrl == ""
                                  ? Icon(Icons.category_outlined,
                                      color: appBarColor)
                                  : ImageBoxFillWidget(
                                      imageUrl: serviceDetails.imageUrl))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(serviceDetails.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'OpenSans-Bold',
                            fontSize: 12.0,
                          )),
                    ),
                    Text(serviceDetails.subTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpenSans-SemiBold',
                          fontSize: 12.0,
                        )),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              //bottom: -10,

              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 30,
                    child: RoundedBtnWidget(
                      title: "More",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoreServiceScreen(
                                serviceDetails:
                                    serviceDetails), //send to data to the next screen
                          ),
                        );
                      },
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
