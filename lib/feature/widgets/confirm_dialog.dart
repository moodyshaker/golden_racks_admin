import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class ConfirmDialog extends StatelessWidget {
  final String content;
  final String imageIconPath;
  final VoidCallback confirmButton;

  const ConfirmDialog({
    required this.content,
    required this.imageIconPath,
    required this.confirmButton,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(

          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20.0)),
          padding:
              EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
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
              const SizedBox(
                height: 20.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            100.0.r,
                          ),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kAccentColor)),
                  onPressed: confirmButton,
                  child: Text(
                    'حسناً',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
