import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class RememberMe extends StatefulWidget {
  final Function(bool) onCheck;
  final String? content;

  const RememberMe({
    required this.onCheck,
    this.content,
  });

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget.content != null
            ? Text(
                widget.content!,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: kTitleColor,
                ),
              )
            : Container(),
        CupertinoSwitch(
            value: isChecked,
            activeColor: kSecondaryColor,
            onChanged: (bool? v) {
              if (v != null) {
                setState(() => isChecked = !isChecked);
                widget.onCheck(isChecked);
              }
            }),
      ],
    );
  }
}
