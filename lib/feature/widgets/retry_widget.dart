import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../../core/localization/demo_localization.dart';
import 'main_text.dart';

class RetryWidget extends StatelessWidget {
  final VoidCallback retryCallback;

  const RetryWidget({required this.retryCallback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainText(
            text: demo.getTranslatedValue('error_occurred'),
            font: 18.sp,
            weight: FontWeight.bold,
            color: kSecondaryColor,
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: retryCallback,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kSecondaryColor)),
            child: MainText(
              text: demo.getTranslatedValue('try_again'),
              font: 16.sp,
              color: kAccentColor,
              weight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
