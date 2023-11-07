import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/bloc/technician_app_cubit.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/feature/admin/auth_screens/organizer_login.dart';
import 'package:golden_racks_admin/feature/screens/profile_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/search_tickets_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/technical_notification_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/units/technician_main.dart';
import '../../constants.dart';
import '../../core/bloc/language_cubit.dart';
import '../../core/localization/demo_localization.dart';
import '../../core/models/nav_item.dart';
import '../../core/router/router.dart';
import 'action_dialog.dart';
import 'main_text.dart';

class TechnicianCustomScaffold extends StatefulWidget {
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

  const TechnicianCustomScaffold({
    this.title1,
    this.title2,
    this.title3,
    this.backgroundColor,
    this.pic = 'icon_background',
    required this.body,
    this.hasAppbar = true,
    this.hasNavBar = true,
    this.isHome = true,
    this.onBackPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<TechnicianCustomScaffold> createState() =>
      _TechnicianCustomScaffoldState();
}

class _TechnicianCustomScaffoldState extends State<TechnicianCustomScaffold> {
  late List<NavItem> navBar;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    navBar = technicianNavItems;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = TechnicianAppCubit.get(context);
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
                  ));
        } else {
          widget.onBackPressed != null
              ? widget.onBackPressed!()
              : MagicRouter.pop();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: widget.backgroundColor ?? kAccentColor,
        drawer: widget.isHome
            ? SafeArea(
                child: Drawer(
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
                    padding:
                        EdgeInsets.only(top: 50.h, right: 20.w, left: 20.w),
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
                                      child: Image.asset(
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
                                    text:
                                        // Preferences
                                        //         .instance.getUserName.isNotEmpty
                                        //     ? Preferences.instance.getUserName
                                        //     :
                                        'مصطفي رضا',
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
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
                  ? Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 10.h, left: 20, right: 20),
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Row(
                            children: [
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    MagicRouter.navigateTo(
                                      TechnicalNotificationScreen(),
                                    );
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
                                child: InkWell(
                                  child: Container(
                                    height: 46.h,
                                    width: 46.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: kSecondaryColor,
                                        width: 2.0,
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            Preferences.instance.getUserImage ==
                                                    ''
                                                ? Image.asset(
                                                    getAsset('icon_background'),
                                                  ).image
                                                : Image.network(
                                                    '${base_url_image}${Preferences.instance.getUserImage}',
                                                  ).image,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    showMenu(
                                      context: context,
                                      position:
                                          RelativeRect.fromLTRB(0, 0, 100, 100),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      items: <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'Profile',
                                          child: Text('عرض البيانات الشخصية'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Log Out',
                                          child: Text('تسجيل الخروج'),
                                        ),
                                      ],
                                    ).then(
                                      (value) => {
                                        if (value != null)
                                          {
                                            if (value == 'Profile')
                                              {
                                                MagicRouter
                                                    .navigateAndPopUntilFirstPage(
                                                  ProfileScreen(),
                                                ),
                                              }
                                            else if (value == 'Log Out')
                                              {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) => ActionDialog(
                                                    content:
                                                        'هل تود تسجيل الخروج؟',
                                                    approveAction: 'نعم',
                                                    cancelAction: 'لا',
                                                    onApproveClick: () async {
                                                      await Preferences.instance
                                                          .logout();
                                                      MagicRouter
                                                          .navigateAndPopAll(
                                                        OrganizerLogin(),
                                                      );
                                                    },
                                                    onCancelClick:
                                                        MagicRouter.pop,
                                                  ),
                                                ),
                                              }
                                          }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    )
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
                                          'do_you_want_exit'),
                                      onCancelClick: () {
                                        MagicRouter.pop();
                                      },
                                      approveAction: demo
                                          .getTranslatedValue('dialog_approve'),
                                      cancelAction: demo
                                          .getTranslatedValue('dialog_decline'),
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
                          cubit.changeCurrent(i);

                          if (i == 0) {
                            print('home sweet home');
                            MagicRouter.navigateAndPopAll(TechnicianMain());
                          } else if (i == 1) {
                            print('tickets 50 cents');
                            MagicRouter.navigateAndPopAll(
                              SearchTicketsScreen(),
                            );
                          } else if (i == 2) {
                            print('board board');
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 6.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
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
                              SizedBox(
                                height: 5.h,
                              ),
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
                ),
              )
            : null,
      ),
    );
  }
}
