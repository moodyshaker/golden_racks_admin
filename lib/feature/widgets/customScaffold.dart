import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../../core/appStorage/shared_preference.dart';
import '../../core/bloc/app_cubit.dart';
import '../../core/bloc/auth_cubit.dart';
import '../../core/bloc/language_cubit.dart';
import '../../core/localization/demo_localization.dart';
import '../../core/models/more_model.dart';
import '../../core/models/nav_item.dart';
import '../../core/router/router.dart';
import 'action_dialog.dart';
import 'main_text.dart';

class CustomScaffold extends StatefulWidget {
  final String? title;
  final bool hasAppbar;
  final bool hasNavBar;
  final bool isHome;
  final Widget body;
  final Color? backgroundColor;

  final Function()? onBackPressed;

  const CustomScaffold(
      {this.title,
      required this.body,
        this.backgroundColor ,
      this.hasAppbar = true,
      this.hasNavBar = true,
      this.isHome = true,
      this.onBackPressed,
      Key? key})
      : super(key: key);

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  late List<MoreModel> list;
  late List<NavItem> navBar;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final demo = DemoLocalization.of(context);
    list = moreList(demo);
    navBar = navItems;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    final demo = DemoLocalization.of(context);
    final lang = LanguageCubit.get(context);
    final auth = AuthCubit.get(context);
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
                  ));
        } else {
          widget.onBackPressed != null
              ? widget.onBackPressed!()
              : MagicRouter.pop();
        }
        return false;
      },
      child: Scaffold(

        backgroundColor: widget.backgroundColor?? kAccentColor,
        drawer: widget.isHome
            ? SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kMainColor, width: 5.0),
                                    shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.r),
                                  child: Preferences
                                          .instance.getUserImage.isNotEmpty
                                      ? FancyShimmerImage(
                                          imageUrl: Preferences
                                              .instance.getUserImage,
                                          height: 100.h,
                                          width: 100.w,
                                          errorWidget: Image.asset(
                                            getAsset('user_profile_icon'),
                                            height: 100.h,
                                            width: 100.w,
                                          ),
                                        )
                                      : Image.asset(
                                          getAsset('user_profile_icon'),
                                          height: 100.h,
                                          width: 100.w,
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              MainText(
                                text: Preferences
                                        .instance.getUserName.isNotEmpty
                                    ? Preferences.instance.getUserName
                                    : '',
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
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
                                      MagicRouter.pop();
                                      if (list[i].hasRoute) {
                                        if (list[i].route != null) {
                                          // if (list[i].route is Profile) {
                                          //   if (Preferences.instance
                                          //               .getUserType ==
                                          //           '0' &&
                                          //       Preferences.instance
                                          //           .getUserToken.isEmpty) {
                                          //     showDialog(
                                          //         context: navigatorKey
                                          //             .currentContext!,
                                          //         builder: (_) =>
                                          //             UnAuthoriazedUserDialog(
                                          //                 isDissmisable:
                                          //                     true));
                                          //   }  else {
                                          //       MagicRouter.navigateTo(
                                          //           list[i].route);
                                          //     }
                                          //   }
                                          // else if (list[i].route
                                          // is CurrentEvent) {
                                          //   if (Preferences.instance
                                          //       .getUserType ==
                                          //       '0' &&
                                          //       Preferences
                                          //           .instance
                                          //           .getUserToken
                                          //           .isEmpty) {
                                          //     showDialog(
                                          //         context: navigatorKey
                                          //             .currentContext!,
                                          //         builder: (_) =>
                                          //             UnAuthoriazedUserDialog(
                                          //                 isDissmisable:
                                          //                 true));
                                          //   }else {
                                          //     MagicRouter.navigateTo(
                                          //         list[i].route);
                                          //   }
                                          // } else {
                                          //   MagicRouter.navigateTo(
                                          //       list[i].route);
                                          // }
                                        }
                                      } else {
                                        switch (list[i].desc!) {
                                          case 'lang':
                                            lang.locale.languageCode == 'en'
                                                ? lang.setLocale(
                                                    Locale('ar', 'EG'))
                                                : lang.setLocale(
                                                    Locale('en', 'US'));
                                            break;
                                          case 'logout':
                                            showDialog(
                                              context: navigatorKey
                                                  .currentContext!,
                                              barrierDismissible: false,
                                              builder: (ctx) =>
                                                  ActionDialog(
                                                content:
                                                    demo.getTranslatedValue(
                                                        'logout_dialog_content'),
                                                onApproveClick: () async {
                                                  MagicRouter.pop();
                                                  await auth.clearData();
                                                },
                                                approveAction:
                                                    demo.getTranslatedValue(
                                                        'dialog_approve'),
                                                cancelAction:
                                                    demo.getTranslatedValue(
                                                        'dialog_decline'),
                                                onCancelClick: () {
                                                  MagicRouter.pop();
                                                },
                                              ),
                                            );
                                            break;
                                        }
                                      }
                                    },
                                    title: MainText(
                                      text: '${list[i].name}',
                                      font: 16.sp,
                                      weight: FontWeight.bold,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 8.h),
                                    trailing: Image.asset(
                                      getAsset('double_arrow'),
                                      height: 24.h,
                                      width: 24.w,
                                    ),
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 36.w),
          child: SafeArea(
              child: Column(
            children: [
              widget.hasAppbar
                  ? Column(children: [
                      Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: MainText(
                                text: widget.title,
                                color: titleColor,
                                font: 16.sp,
                                weight: FontWeight.bold,
                                family: 'Lato_smiBold',
                              ),
                            ),
                            widget.isHome
                                ? Builder(
                                    builder: (context) => GestureDetector(
                                      onTap: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      child: Container(
                                        height: 24.h,
                                        width: 45.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.more_vert_outlined,
                                                color: kAccentColor, size: 30),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
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
                                                    content:
                                                        demo.getTranslatedValue(
                                                            'do_you_want_exit'),
                                                    onCancelClick: () {
                                                      MagicRouter.pop();
                                                    },
                                                    approveAction:
                                                        demo.getTranslatedValue(
                                                            'dialog_approve'),
                                                    cancelAction:
                                                        demo.getTranslatedValue(
                                                            'dialog_decline'),
                                                    onApproveClick: () {
                                                      MagicRouter.pop();
                                                      SystemNavigator.pop();
                                                    },
                                                  ));
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
                    ])
                  : Container(),
              Expanded(child: widget.body),
            ],
          )),
        ),
        bottomNavigationBar: widget.isHome && widget.hasNavBar
            ? SafeArea(
                child: Container(
                  height: 100.h,
                  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff258039),
                            Color(0xff8FC742),
                          ])),
                  child: Row(
                    children: List.generate(
                        navBar.length,
                        (i) => Expanded(
                                child: GestureDetector(
                              onTap: () {
                                cubit.changeCurrent(i);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(getAsset('${navBar[i].icon}'),
                                        height: cubit.i == i ? 30.h : 24.h,
                                        width: cubit.i == i ? 30.w : 24.w,
                                        color: cubit.i == i
                                            ? kAccentColor
                                            : kInactiveColor),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    MainText(
                                        text: navBar[i].title,
                                        font: cubit.i == i ? 14.sp : 12.sp,
                                        color: kAccentColor,
                                        weight: cubit.i == i
                                            ? FontWeight.bold
                                            : FontWeight.w500),
                                  ],
                                ),
                              ),
                            ))),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
