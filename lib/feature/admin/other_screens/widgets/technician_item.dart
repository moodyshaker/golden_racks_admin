import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/technical_model.dart';
import 'package:golden_racks_admin/core/provider/provider_add_technation.dart';
import '../../../../constants.dart';
import '../../../widgets/main_text.dart';

class TechnicianItem extends StatefulWidget {
  final tech;

  const TechnicianItem({
    this.tech,
  });

  @override
  State<TechnicianItem> createState() => _TechnicianItemState();
}

class _TechnicianItemState extends State<TechnicianItem> {
  @override
  Widget build(BuildContext context) {
    final technicalProvider = AddTechnationProvider.get(context);
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
            text: widget.tech.fullName,
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
            onTap: () {
              log(widget.tech.userName!);
            },
          ),
        ],
      ),
    );
  }
}
