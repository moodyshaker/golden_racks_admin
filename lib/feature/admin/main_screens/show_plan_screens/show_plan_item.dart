import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

class ShowPlanItem extends StatefulWidget {
  final int index;

  const ShowPlanItem({required this.index});
  @override
  State<ShowPlanItem> createState() => _ShowPlanItemState();
}

class _ShowPlanItemState extends State<ShowPlanItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.h),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: gray_0,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 1.0, color: gray_10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MainText(
            text: '${arabicPlanTypes[widget.index + 1]}',
            font: 15.sp,
            color: Colors.black,
            weight: FontWeight.w500,
            family: 'Lato',
          ),
          InkWell(
            child: Container(
              height: 28.h,
              width: 28.w,
              child: Image.asset(
                getAsset('eyes_icon'),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
