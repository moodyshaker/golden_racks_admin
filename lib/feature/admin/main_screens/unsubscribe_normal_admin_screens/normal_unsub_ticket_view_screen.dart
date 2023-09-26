import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/normal_plan_unsub_model.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/video_preview_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/unsubscribe_normal_admin_screens/admin_assign_technical_screen_for_normal_unsub.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:path/path.dart' as pathFile;

import '../../../../constants.dart';

class NormalUnsubTicketViewScreen extends StatefulWidget {
  final NormalPlanUnSubModel normalUnsub;

  const NormalUnsubTicketViewScreen({required this.normalUnsub});

  @override
  State<NormalUnsubTicketViewScreen> createState() =>
      _NormalUnsubTicketViewScreenState();
}

class _NormalUnsubTicketViewScreenState
    extends State<NormalUnsubTicketViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background2')),
          fit: BoxFit.fill,
        ),
      ),
      child: OrganizerCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: false,
        isHome: true,
        hasNavBar: true,
        title1: 'عرض تذكرة رقم  ${widget.normalUnsub.ticketNumber}',
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: gray_20,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(width: 1.0, color: kInactiveColor),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 19.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: MainText(
                          text: 'شركة ${widget.normalUnsub.companyName_Ar}',
                          font: 16.sp,
                          weight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: MainText(
                          text:
                              'رقم التذكرة ${widget.normalUnsub.ticketNumber}',
                          font: 14.sp,
                          weight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 27.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: MainText(
                      text: '${widget.normalUnsub.problemName}',
                      font: 16.sp,
                      weight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        MainText(
                          text: 'الفني',
                          font: 12.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                          onTap: () {
                            MagicRouter.navigateTo(
                              AdminAssignTechnicalForNormalUnsubScreen(
                                normalUnsub: widget.normalUnsub,
                              ),
                            );
                          },
                          child: MainText(
                            text: 'تخصيص فني الان',
                            font: 15.sp,
                            weight: FontWeight.w600,
                            color: kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        MainText(
                          text: 'التاريخ',
                          font: 12.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MainText(
                          text: formateDateTimeToDate(
                            widget.normalUnsub.addedDate!,
                          ),
                          font: 15.sp,
                          weight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: MainText(
                      text: 'تفاصيل المشكلة تسجيل صوتي',
                      font: 12.sp,
                      weight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: InkWell(
                      onTap: () async {
                        final player = AudioPlayer();
                        var path =
                            'http://75.119.156.82/${widget.normalUnsub.sound}';
                        log(path);
                        await player.play(
                          UrlSource(path),
                        );
                      },
                      child: Container(
                        height: 56.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 10.w,
                          horizontal: 30.h,
                        ),
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(width: 1.0, color: mainColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 24.h,
                              width: 24.w,
                              child: Image.asset(
                                getAsset('play_icon'),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            MainText(
                              text: 'تشغيل الملف الصوتي الخاص بالمشكلة',
                              color: Colors.white,
                              font: 12.sp,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 19.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: MainText(
                      text: 'الصور والفيديو الخاصين بالمشكلة',
                      font: 12.sp,
                      weight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 74.h,
                        width: 74.w,
                        child: widget.normalUnsub.problemDetails!.length < 1
                            ? Image.asset(getAsset('no_pic'))
                            : CustomNetworkFileImage(
                                path:
                                    'http://75.119.156.82/${widget.normalUnsub.problemDetails![0].fileName}',
                              ),
                      ),
                      Container(
                        height: 74.h,
                        width: 74.w,
                        child: widget.normalUnsub.problemDetails!.length < 2
                            ? Image.asset(getAsset('no_pic'))
                            : CustomNetworkFileImage(
                                path:
                                    'http://75.119.156.82/${widget.normalUnsub.problemDetails![1].fileName}',
                              ),
                      ),
                      Container(
                        height: 74.h,
                        width: 74.w,
                        child: widget.normalUnsub.problemDetails!.length < 3
                            ? Image.asset(getAsset('no_pic'))
                            : CustomNetworkFileImage(
                                path:
                                    'http://75.119.156.82/${widget.normalUnsub.problemDetails![2].fileName}',
                              ),
                      ),
                      Container(
                        height: 74.h,
                        width: 74.w,
                        child: widget.normalUnsub.problemDetails!.length < 4
                            ? Image.asset(getAsset('no_pic'))
                            : CustomNetworkFileImage(
                                path:
                                    'http://75.119.156.82/${widget.normalUnsub.problemDetails![3].fileName}',
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNetworkFileImage extends StatefulWidget {
  final String path;
  const CustomNetworkFileImage({
    required this.path,
  });

  @override
  State<CustomNetworkFileImage> createState() => _CustomNetworkFileImageState();
}

class _CustomNetworkFileImageState extends State<CustomNetworkFileImage> {
  @override
  Widget build(BuildContext context) {
    bool isVideo = false;
    String extension = pathFile.extension(widget.path).toLowerCase();
    if (extension == '.mp4' ||
        extension == '.avi' ||
        extension == '.mov' ||
        extension == '.mkv' ||
        extension == '.wmv' ||
        extension == '.flv' ||
        extension == '.ts' ||
        extension == '.ogv' ||
        extension == '.webm' ||
        extension == '.m4v' ||
        extension == '.3gp') {
      isVideo = true;
    } else {
      isVideo = false;
    }

    if (!isVideo) {
      return InkWell(
        child: Image.network(
          '${widget.path}',
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Image.network(
                  '${widget.path}',
                ),
              );
            },
          );
        },
      );
    } else {
      return InkWell(
        child: Image(
          image: AssetImage(
            getAsset('video_loading'),
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                contentPadding: EdgeInsets.zero,
                content: CustomVideoPlayer(
                  path: widget.path,
                ),
              );
            },
          );
        },
      );
    }
  }
}