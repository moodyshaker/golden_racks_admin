// import 'package:aman_supervisor/core/dioHelper/dio_helper.dart';
// import 'package:aman_supervisor/core/router/router.dart';
// import 'package:aman_supervisor/features/setting_screens/splash/view.dart';
// import 'package:aman_supervisor/generated/locale_keys.g.dart';
// import 'package:easy_localization/src/public_ext.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../constants.dart';
// import 'customButton.dart';
// import 'main_text.dart';
// import 'other_text.dart';
//
// class LanguageSheet extends StatefulWidget {
//   const LanguageSheet({Key? key}) : super(key: key);
//
//   @override
//   State<LanguageSheet> createState() => _LanguageSheetState();
// }
//
// class _LanguageSheetState extends State<LanguageSheet> {
//   late bool isSwitched;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (context.locale == Locale('en', 'US')) {
//       setState(() {
//         isSwitched = true;
//
//       });
//     } else {
//       isSwitched = false;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300.sp,
//       color: Colors
//           .transparent, //could change this to Color(0xFF737373),
//       //so you don't have to change MaterialApp canvasColor
//       child: Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: 20.sp, vertical: 20.sp),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15.r),
//                   topRight:
//                   Radius.circular(15.r))),
//           child: Column(
//             mainAxisAlignment:
//             MainAxisAlignment.spaceBetween,
//             crossAxisAlignment:
//             CrossAxisAlignment.start,
//             children: [
//               MainText(
//                 text: LocaleKeys.language.tr(),
//                 font: 20.sp,
//               ),
//               OtherText(
//                 text: "Choose language of app",
//                 hor: 0,
//                 font: 14.sp,
//                 family: "montserrate semiBold",
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     isSwitched= false;
//                   });
//                 },
//                 child: Container(
//                   // margin: EdgeInsets.only(top:height*.02),
//                   color: Colors.transparent,
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         getAsset(isSwitched==true?"circle":"check"),
//                         height: 20.h,
//                         width: 20.w,
//                       ),
//                       // :Image.asset(getAsset("circle"),height: 20.h,width: 20.w,),
//                       SizedBox(width: 20.w),
//                       Text(
//                         "العربية",
//                         style: TextStyle(
//                             fontSize: 18.sp,
//                             color: kPrimaryColor,
//                             fontFamily:
//                             "montserrate bold"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     isSwitched= true;
//                   });
//
//                 },
//                 child: Container(
//                   // margin: EdgeInsets.only(top:height*.02),
//                   color: Colors.transparent,
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         getAsset(isSwitched==false?"circle":"check"),
//                         height: 20.h,
//                         width: 20.w,
//                       ),
//                       // :Image.asset(getAsset("circle"),height: 20.h,width: 20.w,),
//                       SizedBox(width: 20.w),
//                       Text(
//                         "English",
//                         style: TextStyle(
//                             fontSize: 16.sp,
//                             color: kPrimaryColor,
//                             fontFamily:
//                             "montserrate semiBold"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               CustomButton(
//                 title: LocaleKeys.done.tr(),
//                 onPressed: (){
//                   if (isSwitched == true) {
//                     setState(() {
//                       context.locale = Locale('en', 'US');
//                       context.setLocale(Locale('en', 'US'));
//                       isSwitched = false;
//                       DioHelper.lang="ar";
//                     });
//
//                     // MagicRouter.navigateAndPopAll(SplashView());
//
//                   } else {
//                     setState(() {
//                       context.locale = Locale('ar', 'EG');
//                       context.setLocale(Locale('ar', 'EG'));
//                       DioHelper.lang = "en";
//                       isSwitched = true;
//                     });
//
//                     // MagicRouter.navigateAndPopAll(SplashView());
//                   }
//                 },
//               ),
//             ],
//           )),
//     );
//   }
// }
