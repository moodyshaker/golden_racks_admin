import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/emergency_plan_sub_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_add_technation.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_sub_emergency_plan.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_technician_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/technician_item.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import 'package:golden_racks_admin/feature/widgets/customTextFeild.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import '../../../../constants.dart';

class AdminAssignTechnicalForEmergencySubScreen extends StatefulWidget {
  final EmergencyPlanSubModel emergencySub;

  AdminAssignTechnicalForEmergencySubScreen({required this.emergencySub});

  @override
  State<AdminAssignTechnicalForEmergencySubScreen> createState() =>
      _AdminAssignTechnicalForEmergencySubScreenState();
}

class _AdminAssignTechnicalForEmergencySubScreenState
    extends State<AdminAssignTechnicalForEmergencySubScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  DateTime? chosenTime;

  @override
  void initState() {
    super.initState();
    AddTechnationProvider.listenFalse(context).getallTechnation(
      userFullName: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final addTechProvider = AddTechnationProvider.get(context);
    final emergencySubProvider = AssignToSubEmergencyProvider.get(context);

    return Form(
      key: _form,
      child: Container(
        height: double.infinity,
        width: double.infinity,
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
          title1: 'اضافة فني لخطة صيانة',
          body: addTechProvider.techStatus == NetworkStatus.loading
              ? OpacityLoadingLogo()
              : addTechProvider.techStatus == NetworkStatus.success
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              MagicRouter.navigateTo(AddTechnicianScreen());
                            },
                            child: Container(
                              height: 56.h,
                              width: 200.h,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.w,
                                horizontal: 30.h,
                              ),
                              margin: EdgeInsets.only(
                                bottom: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(30.r),
                                border:
                                    Border.all(width: 1.0, color: mainColor),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 32.h,
                                    width: 32.w,
                                    child: Image.asset(
                                      getAsset('add_icon'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  MainText(
                                    text: 'اضافة فني',
                                    color: Colors.white,
                                    font: 16.sp,
                                    weight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            child: CustomTextField(
                              controller: addTechProvider.searchTechController,
                              borderColor: mainColor,
                              hint: 'ابحث عن فني',
                              horizontalPadding: 16.w,
                              suffixIcon: InkWell(
                                child: Container(
                                  width: 60.w,
                                  child: Center(
                                    child: Container(
                                      height: 32.h,
                                      width: 32.w,
                                      child: Image.asset(
                                        getAsset('search_icon'),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => LoadingDialog(),
                                  );
                                  await addTechProvider.getallTechnation(
                                    userFullName:
                                        '${addTechProvider.searchTechController.text}',
                                  );
                                  MagicRouter.pop();
                                },
                              ),
                              hasHint: true,
                              suffixCallback: () {},
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomButton(
                            title: 'اسم الفني',
                            color: backColor,
                            height: 50.h,
                            font: 15.sp,
                            radius: 8.r,
                            family: 'Lato_bold',
                            weight: FontWeight.w800,
                            textColor: Colors.black,
                            withBorder: false,
                            onPressed: () async {},
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Container(
                            height: 235.h,
                            child: addTechProvider.allTechnicals.isEmpty
                                ? MainText(
                                    text: 'لا يوجد فني بهذا الاسم',
                                  )
                                : ListView.separated(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    itemBuilder: (BuildContext context, int i) {
                                      return InkWell(
                                        onTap: () {
                                          if (_form.currentState!.validate()) {
                                            log('${chosenTime.toString()}');
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      16.0,
                                                    ),
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      MainText(
                                                        text:
                                                            'هل تريد اضافة هذا الفني ؟',
                                                      ),
                                                      SizedBox(height: 6),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          MaterialButton(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            color: Colors.green,
                                                            onPressed:
                                                                () async {
                                                              MagicRouter.pop();
                                                              await emergencySubProvider
                                                                  .assignTechForSubEmergency(
                                                                UserId: widget
                                                                    .emergencySub
                                                                    .userId!,
                                                                TechnicalId:
                                                                    addTechProvider
                                                                        .allTechnicals[
                                                                            i]
                                                                        .userId!,
                                                                VisitWithSubscribeId: widget
                                                                    .emergencySub
                                                                    .problemDetails![
                                                                        0]
                                                                    .visitWithSubscripeId!,
                                                                // VisitDate:
                                                                //     chosenTime
                                                                //         .toString(),
                                                                VisitDate: DateTime
                                                                        .now()
                                                                    .add(Duration(
                                                                        hours:
                                                                            4))
                                                                    .toString(),
                                                                IsActive: true,
                                                              );
                                                            },
                                                            child: MainText(
                                                              text: 'OK',
                                                            ),
                                                          ),
                                                          MaterialButton(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              MagicRouter.pop();
                                                            },
                                                            child: MainText(
                                                              text: 'NO',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: TechnicianItem(
                                          tech:
                                              addTechProvider.allTechnicals[i],
                                        ),
                                      );
                                    },
                                    itemCount:
                                        addTechProvider.allTechnicals.length,
                                    separatorBuilder: ((context, index) =>
                                        SizedBox(
                                          height: 8.h,
                                        )),
                                  ),
                          ),
                          SizedBox(
                            height: 27.h,
                          ),
                          // CustomButton(
                          //   title: 'اختيار تاريخ الخطة',
                          //   color: kSecondaryColor,
                          //   height: 50.h,
                          //   font: 16.sp,
                          //   family: 'Lato_bold',
                          //   textColor: Colors.white,
                          //   withBorder: false,
                          //   onPressed: () async {
                          //     chosenTime = await showDatePicker(
                          //       context: context,
                          //       initialDate: chosenTime ??= DateTime.now(),
                          //       firstDate: DateTime(2000),
                          //       lastDate: DateTime(2101),
                          //       builder: ((context, child) {
                          //         return Theme(
                          //           data: ThemeData.light().copyWith(
                          //             colorScheme: ColorScheme.light(
                          //               primary: Colors.brown,
                          //               onPrimary: Colors.white,
                          //               surface: Colors.white,
                          //               onSurface: Colors.brown,
                          //             ),
                          //           ),
                          //           child: child!,
                          //         );
                          //       }),
                          //     );
                          //   },
                          // ),
                          // FormField(
                          //   builder: (FormFieldState<String> state) {
                          //     return MainText(
                          //       text: state.errorText ?? '',
                          //       color: Colors.red,
                          //       font: 16.sp,
                          //       horizontalPadding: 16.w,
                          //       // verticalPadding: 8.h,
                          //     );
                          //   },
                          //   validator: (v) {
                          //     if (chosenTime == null) {
                          //       return 'من فضلك ادخل تاريخ الخطة';
                          //     } else {
                          //       return null;
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    )
                  : RetryWidget(
                      retryCallback: () {
                        addTechProvider.getallTechnation(
                          userFullName: '',
                          retry: true,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
