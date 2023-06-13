import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmSendingEmailBottomSheet extends StatelessWidget {
  final String content;
  final String imageIconPath;

  const ConfirmSendingEmailBottomSheet({
    required this.content,
    required this.imageIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        padding:
            EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageIconPath,
              height: 61.h,
              width: 61.h,
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
