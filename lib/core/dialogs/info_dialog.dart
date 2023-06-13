import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../feature/widgets/main_text.dart';

class InfoDialog extends StatelessWidget {
  final String content;
  final String? imagePath;

  const InfoDialog({required this.content, this.imagePath, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        backgroundColor: kAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath != null
                    ? getAsset(imagePath!)
                    : getAsset('done_icon'),
                height: 80.h,
                width: 80.w,
              ),
              MainText(
                text: content,
                font: 16.sp,
                color: kBlackColor,
                weight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
