import 'package:flutter/material.dart';

import '../../constants.dart';

class ConfirmButton extends StatelessWidget {
  ConfirmButton({
    required this.title, required this.onPressed, this.color = kPrimaryColor,
    this.verticalMargin = 0.0, this.horizontalMargin = 0.0,
    this.titleColor = Colors.white
});

  final String title;
  final double horizontalMargin;
  final double verticalMargin;
  final VoidCallback? onPressed;
  final Color color;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin,vertical: verticalMargin),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title, style: TextStyle(color: titleColor),),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
      ),
    );
  }
}
