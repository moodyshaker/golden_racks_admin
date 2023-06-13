import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../../core/bloc/auth_cubit.dart';
import '../../core/bloc/language_cubit.dart';
import '../../core/httpHelper/http_helper.dart';
import '../../core/models/event_category_model.dart';
import 'main_text.dart';

class InterestsItem extends StatefulWidget {
  final EventCategoryModel model;
  final int currentIndex;

  const InterestsItem(
      {required this.model, required this.currentIndex, Key? key})
      : super(key: key);

  @override
  State<InterestsItem> createState() => _InterestsItemState();
}

class _InterestsItemState extends State<InterestsItem> {
  @override
  Widget build(BuildContext context) {
    final lang = LanguageCubit.get(context);
    final auth = AuthCubit.get(context);
    return Container(
        padding: EdgeInsets.only(left: 8.w, top: 2.h, bottom: 2.h),
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child:
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Checkbox(
            //         value: _value,
            //         onChanged: (bool? v) {
            //           setState(() {
            //             _value = v!;
            //           });
            //           widget.callback(widget.model.id!, v!);
            //         }),
            //     MainText(
            //       text: lang.locale.languageCode == 'ar'
            //           ? widget.model.nameAr
            //           : widget.model.nameEn,
            //       weight: FontWeight.bold,
            //     ),
            //   ],
            // ),
            Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child:widget.model.eventCategoryLogo != null ? FancyShimmerImage(
                      imageUrl: '$base_url_image${widget.model.eventCategoryLogo!}',
                      errorWidget: Image.asset(
                        getAsset('event_image'),
                      ),
                    ):Image.asset(
                      getAsset('event_image'),
                    )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          kAccentColor.withOpacity(0.1),
                          kMainLighterColor,
                        ]),
                  ),
                ),
                MainText(
                  text: lang.locale.languageCode == 'ar'
                      ? widget.model.nameAr
                      : widget.model.nameEn,
                  font: 17.sp,
                  color: kAccentColor,
                  weight: FontWeight.bold,
                )
              ],
            ),
            auth.interestsList.contains(widget.model.id)
                ? Icon(
                    Icons.done,
                    size: 60,
                    color: kAccentColor,
                  )
                : Container(),
          ],
        ));
  }
}
