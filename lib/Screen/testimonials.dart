import 'package:demopatient/utilities/color.dart';
import 'package:demopatient/widgets/appbarsWidget.dart';
import 'package:demopatient/widgets/errorWidget.dart';
import 'package:demopatient/widgets/imageWidget.dart';
import 'package:demopatient/widgets/loadingIndicator.dart';
import 'package:demopatient/widgets/noDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:demopatient/Service/tesimonialsService.dart';

class Testimonials extends StatefulWidget {
  Testimonials({Key key}) : super(key: key);

  @override
  _TestimonialsState createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          CAppBarWidget(title: "Testimonials"),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: FutureBuilder(
                  future: TestimonialsService
                      .getData(), //fetch all testimonials details
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData)
                      return snapshot.data.length == 0
                          ? NoDataWidget()
                          : _listCard(snapshot.data);
                    else if (snapshot.hasError)
                      return IErrorWidget(); //if any error then you can also use any other widget here
                    else
                      return LoadingIndicatorWidget();
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget _listCard(testimonials) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: testimonials.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 10, left: 10),
            child: Stack(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 50, right: 8),
                          child: Text(
                            "${testimonials[index].description} \n\n - ${testimonials[index].name}",
                            style: TextStyle(
                              fontFamily: 'OpenSans-SemiBold',
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey[200],
                      child: ClipOval(
                          child: testimonials[index].imageUrl == ""
                              ? Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                )
                              : ImageBoxFillWidget(
                                  imageUrl: testimonials[index].imageUrl,
                                )),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
