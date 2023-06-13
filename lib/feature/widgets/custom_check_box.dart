import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../core/bloc/home_cubit.dart';

class CustomCheckbox extends StatelessWidget {
  final int index;
  final Function onCheck;
  final String? content;

  const CustomCheckbox({
    required this.index,
    required this.onCheck,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    final HomeCubit cubit = HomeCubit.get(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        cubit.changeCheckbox(index);
        onCheck(index);
      },
      child: Row(
        children: [
          Container(
            width: 23.h,
            height: 23.h,
            margin: EdgeInsets.only(right: 8.w,left: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: cubit.value == index ? kMainColor : Colors.transparent,
              border: Border.all(color: kAccentColor),
            ),
            child: Center(
              child: cubit.value == index
                  ? const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 20,
                    )
                  : null,
            ),
          ),
          content != null
              ? Text(
                  content!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: kAccentColor,
                  ),
                )
              : Container(),
          SizedBox(width: 8.w,),
        ],
      ),
    );
  }
}
