import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:golden_racks_admin/constants.dart';

class OpacityLoadingLogo extends StatefulWidget {
  const OpacityLoadingLogo({Key? key}) : super(key: key);

  @override
  State<OpacityLoadingLogo> createState() => _OpacityLoadingLogoState();
}

class _OpacityLoadingLogoState extends State<OpacityLoadingLogo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitDoubleBounce(
              color: kSecondaryColor,
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
