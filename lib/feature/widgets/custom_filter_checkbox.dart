import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../../core/bloc/home_cubit.dart';
import '../../core/bloc/language_cubit.dart';
import '../../core/models/event_category_model.dart';
import 'custom_checkbox.dart';
import 'main_checkbox_filter.dart';

class CustomFilterCheckbox extends StatefulWidget {
  final EventCategoryModel model;

  const CustomFilterCheckbox({required this.model, Key? key}) : super(key: key);

  @override
  State<CustomFilterCheckbox> createState() => _CustomFilterCheckboxState();
}

class _CustomFilterCheckboxState extends State<CustomFilterCheckbox> {
  bool _mainValue = false;

  @override
  Widget build(BuildContext context) {
    final home = HomeCubit.get(context);
    final lang = LanguageCubit.get(context);
    return Column(
      children: [
        MainCheckboxFilter(
          onCheck: (bool v) {
            setState(() {
              _mainValue = v;
            });
            if (v) {
              widget.model.subEventCategoryDtos!.map((e) => e.id).toList().forEach((e) {
                home.cats.remove(e);
              });
              home.cats.add(widget.model.id!);
            } else {
              home.cats.remove(widget.model.id!);
            }
          },
          content: lang.locale.languageCode == 'en'
              ? widget.model.nameEn
              : widget.model.nameAr,
          leftCheckbox: false,
          rightCheckbox: true,
          rightCheckRightMargin: 0.w,
          textColor: kBlackColor,
          weight: FontWeight.bold,
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          height: 40.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.model.subEventCategoryDtos!.length,
            itemBuilder: (BuildContext, int t) => SubFilterCheckbox(
              mainValue: _mainValue,
              model: widget.model.subEventCategoryDtos![t],
              leftCheckbox: false,
              rightCheckbox: true,
              rightCheckRightMargin: t == 0 ? 0.0.w : 8.w,
              textColor: kBlackColor,
              weight: FontWeight.w300,
              onCheck: (bool v) {},
            ),
          ),
        ),
      ],
    );
  }
}
