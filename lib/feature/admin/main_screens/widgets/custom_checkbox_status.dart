import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants.dart';
import '../../../../core/bloc/organizer_app_cubit.dart';

class CustomCheckboxStatus extends StatelessWidget {
  final int index;
  final Function onCheck;
  final String? content;

  const CustomCheckboxStatus({
    required this.index,
    required this.onCheck,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    final OrganizerAppCubit cubit = OrganizerAppCubit.get(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        cubit.changeCheckboxStatus(index);
        onCheck(index);
      },
      child: Row(
        children: [
          Container(
            width: 23.h,
            height: 23.h,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: cubit.status == index ? kMainColor : Colors.transparent,
              border: Border.all(color: kAccentColor),
            ),
            child: Center(
              child: cubit.status == index
                  ? const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
          content != null
              ? SizedBox(
                  width: size.width * 0.02,
                )
              : Container(),
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
        ],
      ),
    );
  }
}
