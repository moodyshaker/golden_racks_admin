import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../../core/bloc/app_cubit.dart';
import '../../core/bloc/auth_cubit.dart';
import '../../core/bloc/language_cubit.dart';
import '../../core/localization/demo_localization.dart';
import '../../core/models/more_model.dart';
import '../../core/models/nav_item.dart';
import '../../core/router/router.dart';
import 'action_dialog.dart';
import 'main_text.dart';

class MainScaffold extends StatefulWidget {
  final String? title;
  final String? title1;
  final String? title2;
  final String? title3;
  final bool hasBack;
  final bool hasAppbar;
  final bool hasNavBar;
  final bool isHome;
  final Widget body;

  final Function()? onBackPressed;

  const MainScaffold(
      {this.title,
        this.title1,
        this.title2,
        this.title3,
        this.hasBack = true,
        required this.body,
      this.hasAppbar = true,
      this.hasNavBar = true,
      this.isHome = true,
      this.onBackPressed,
      Key? key})
      : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffold();
}

class _MainScaffold extends State<MainScaffold> {
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
        body: SafeArea(
            child: Column(
            children: [
            widget.hasAppbar
                ? Column(children: [
                    Container(
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                          // gradient: LinearGradient(
                          //     begin: Alignment.topCenter,
                          //     end: Alignment.bottomCenter,
                          //     colors: [
                          //   Color(0xff258039),
                          //   Color(0xff8FC742),
                          // ],
                          // ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 36.0),
                              child: MainText(
                                text: widget.title,
                                color: Colors.black,
                                font: 16.sp,
                                weight: FontWeight.bold,
                              ),
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
                                  // gradient: LinearGradient(
                                  //     begin: Alignment.topCenter,
                                  //     end: Alignment.bottomCenter,
                                  //     colors: [
                                  //   Color(0xff258039),
                                  //   Color(0xff8FC742),
                                  // ],
                                  // ),
                                ),
                                  height: 41.h,
                                  width: 41.w,
                                  margin: EdgeInsets.only(left: 36.0),
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
                    SizedBox(
                      height: 20.h,
                    ),
                  ])
                : Container(),
            Expanded(child: widget.body),
          ],
        )),
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
