import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../feature/widgets/main_text.dart';
import '../router/router.dart';

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
      child: AlertDialog(
        backgroundColor: kAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath != null ? getAsset(imagePath!) : getAsset('done_icon'),
              height: 80.h,
              width: 80.w,
              color: kSecondaryColor,
            ),
            MainText(
              text: content,
              font: 16.sp,
              color: kBlackColor,
              weight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            TextButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(100.w, 40.h),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(kSecondaryColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                MagicRouter.pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
