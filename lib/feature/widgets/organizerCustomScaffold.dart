import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/home.dart';
import '../../constants.dart';
import '../../core/bloc/language_cubit.dart';
import '../../core/bloc/organizer_app_cubit.dart';
import '../../core/localization/demo_localization.dart';
import '../../core/models/nav_item.dart';
import '../../core/router/router.dart';
import '../technician/main_screens/notification_screen.dart';
import 'action_dialog.dart';
import 'main_text.dart';

class OrganizerCustomScaffold extends StatefulWidget {
  final String? title1;
  final String? title2;
  final String? title3;
  final String? pic;
  final bool hasAppbar;
  final bool hasNavBar;
  final bool isHome;
  final Widget body;
  final Color? backgroundColor;

  final Function()? onBackPressed;

  const OrganizerCustomScaffold({
    this.title1,
    this.title2,
    this.title3,
    this.backgroundColor,
    this.pic = 'amazon_logo',
    required this.body,
    this.hasAppbar = true,
    this.hasNavBar = true,
    this.isHome = true,
    this.onBackPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<OrganizerCustomScaffold> createState() =>
      _OrganizerCustomScaffoldState();
}

class _OrganizerCustomScaffoldState extends State<OrganizerCustomScaffold> {
  // late List<MoreModel> list;
  late List<NavItem> navBar;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // list = organizerMoreList(demo);
    navBar = organizerNavItems;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = OrganizerAppCubit.get(context);
    final demo = DemoLocalization.of(context);
    final lang = LanguageCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        if (!MagicRouter.canPop) {
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (c) => ActionDialog(
              content: demo.getTranslatedValue('do_you_want_exit'),
              onCancelClick: () {
                MagicRouter.pop();
              },
              approveAction: demo.getTranslatedValue('dialog_approve'),
              cancelAction: demo.getTranslatedValue('dialog_decline'),
              onApproveClick: () {
                MagicRouter.pop();
                SystemNavigator.pop();
              },
            ),
          );
        } else {
          widget.onBackPressed != null
              ? widget.onBackPressed!()
              : MagicRouter.pop();
        }
        return false;
      },
      child: Scaffold(
        key: _key,
        backgroundColor: widget.backgroundColor ?? kAccentColor,
        drawer: widget.isHome
            ? SafeArea(
                child: Drawer(
                  width: 330.w,
                  shape: RoundedRectangleBorder(
                    borderRadius: lang.locale.languageCode == 'ar'
                        ? BorderRadius.only(
                            topLeft: Radius.circular(50.r),
                            bottomLeft: Radius.circular(50.r),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(50.r),
                            bottomRight: Radius.circular(50.r),
                          ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h, right: 8.w, left: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: MainText(
                            text: 'القائمة الرئيسية',
                            font: 24.sp,
                            weight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                list.length,
                                (i) => ListTile(
                                  onTap: () {
                                    if (list[i].route != null) {
                                      MagicRouter.pop();
                                      MagicRouter.navigateTo(list[i].route!);
                                    } else {
                                      MagicRouter.pop();
                                    }
                                  },
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 0.h,
                                  ),
                                  subtitle: Row(
                                    children: List.generate(
                                      15,
                                      (index) => Container(
                                        color: kBorderColor,
                                        width: 4.w,
                                        height: 1.h,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 2.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: MainText(
                                          text: list[i].title,
                                          font: 14.sp,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                      list[i].count != null
                                          ? DottedBorder(
                                              color: kSecondaryColor,
                                              borderType: BorderType.Circle,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 8.h,
                                              ),
                                              strokeWidth: 1,
                                              child: Center(
                                                child: MainText(
                                                  text: list[i].count,
                                                  font: 14.sp,
                                                  color: kBlackColor,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Image.asset(
                                        getAsset('double_arrow'),
                                        color: Colors.black54,
                                        height: 18.h,
                                        width: 18.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : null,
        body: SafeArea(
          child: Column(
            children: [
              widget.hasAppbar
                  ? Column(children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.h, left: 20, right: 20),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Row(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  MagicRouter.navigateTo(NotificationScreen());
                                },
                                child: Container(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Image.asset(
                                    getAsset('notification_icon'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 20.0),
                                child: Column(
                                  children: [
                                    Center(
                                      child: MainText(
                                        text: widget.title1,
                                        color: Colors.black,
                                        font: 12.sp,
                                        weight: FontWeight.w800,
                                      ),
                                    ),
                                    Center(
                                      child: MainText(
                                        text: widget.title2,
                                        color: Colors.black,
                                        font: 12.sp,
                                        weight: FontWeight.w800,
                                      ),
                                    ),
                                    Center(
                                      child: MainText(
                                        text: widget.title3,
                                        color: Colors.brown,
                                        font: 8.sp,
                                        weight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 33.h,
                                  width: 68.w,
                                  child: Image.asset(
                                    getAsset(widget.pic!),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ])
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 22.w),
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: MainText(
                              text: widget.title1,
                              color: Colors.black,
                              font: 16.sp,
                              weight: FontWeight.w800,
                              family: 'Lato_smiBold',
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            height: 41.h,
                            width: 41.w,
                            child: GestureDetector(
                              child: Image.asset(getAsset('back')),
                              onTap: () {
                                if (!MagicRouter.canPop) {
                                  showDialog(
                                    context: navigatorKey.currentContext!,
                                    builder: (c) => ActionDialog(
                                      content: demo.getTranslatedValue(
                                        'do_you_want_exit',
                                      ),
                                      onCancelClick: () {
                                        MagicRouter.pop();
                                      },
                                      approveAction: demo.getTranslatedValue(
                                        'dialog_approve',
                                      ),
                                      cancelAction: demo.getTranslatedValue(
                                        'dialog_decline',
                                      ),
                                      onApproveClick: () {
                                        MagicRouter.pop();
                                        SystemNavigator.pop();
                                      },
                                    ),
                                  );
                                } else {
                                  widget.onBackPressed != null
                                      ? widget.onBackPressed!()
                                      : MagicRouter.pop();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
              Expanded(child: widget.body),
            ],
          ),
        ),
        bottomNavigationBar: widget.isHome && widget.hasNavBar
            ? SafeArea(
                child: Container(
                  height: 100.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      navBar.length,
                      (i) => GestureDetector(
                        onTap: () {
                          if (i == 2) {
                            log('home');
                            MagicRouter.navigateAndPopAll(AdminHome());
                            cubit.changeCurrent(i);
                          } else if (i == 0) {
                            cubit.changeCurrent(i);
                            _key.currentState!.openDrawer();
                          } else {
                            cubit.changeCurrent(i);
                          }
                        },
                        child: i == 2
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 6.h),
                                child: Container(
                                  height: cubit.i == i ? 60.h : 55.h,
                                  width: cubit.i == i ? 60.w : 55.w,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 6.h,
                                    horizontal: 6.w,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    vertical: 6.h,
                                    horizontal: 6.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kAccentColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 4.h),
                                      // child: Image.asset(
                                      //   getAsset('${navBar[i].icon}'),
                                      //   height: 24.h,
                                      //   width: 24.w,
                                      //   color: kBlackColor,
                                      // ),
                                      child: Icon(
                                        Icons.home,
                                        color: kSecondaryColor,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    getAsset('${navBar[i].icon}'),
                                    height: cubit.i == i ? 30.h : 24.h,
                                    width: cubit.i == i ? 30.w : 24.w,
                                    color: cubit.i == i
                                        ? kAccentColor
                                        : kInactiveColor,
                                  ),
                                  SizedBox(height: 5.h),
                                  MainText(
                                    text: navBar[i].title,
                                    font: cubit.i == i ? 14.sp : 12.sp,
                                    color: kAccentColor,
                                    weight: cubit.i == i
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
