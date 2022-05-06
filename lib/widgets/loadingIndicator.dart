import 'package:flutter/material.dart';
import 'package:demopatient/utilities/color.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(iconsColor),
        ),
        height: 20.0,
        width: 20.0,
      ),
    );
  }
}
