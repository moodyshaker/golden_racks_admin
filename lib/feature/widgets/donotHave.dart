import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoNotHave extends StatelessWidget {
  final String? text;
  final String? have;
  final bool? ali;
  final VoidCallback? route;

  DoNotHave({this.text, this.route, this.have, this.ali});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$have ',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: "IBM",
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )),
        GestureDetector(
          onTap: route,
          child: Text(text!,
              style: TextStyle(
                fontSize: 14.sp,
                decoration: TextDecoration.underline,
                fontFamily: 'IBM',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              )),
        ),
      ],
    );
  }
}
