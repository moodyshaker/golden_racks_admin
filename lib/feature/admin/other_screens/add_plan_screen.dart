import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_ready_plan.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/plan_item.dart';
import 'package:golden_racks_admin/feature/widgets/customTextFeild.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';

import '../../../../constants.dart';
import '../../widgets/drop_menu.dart';
import '../../widgets/organizerCustomScaffold.dart';

class AddPlanScreen extends StatefulWidget {
  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  @override
  void initState() {
    super.initState();
    ReadyPlanProvider.listenFalse(context).getReadyPlan(
      planDuration: 0,
      planName: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final readyPlanProvider = ReadyPlanProvider.get(context);
    return Container(
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
        title1: 'اضافة خطة صيانة للحساب',
        body: readyPlanProvider.getReadyPlanStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : readyPlanProvider.getReadyPlanStatus == NetworkStatus.success
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropMenu(
                          hint: ('اختر مدة الخطة'),
                          items: arabicPlanTypes,
                          onChanged: (v) async {
                            showDialog(
                              context: context,
                              builder: (context) => LoadingDialog(),
                            );
                            readyPlanProvider.chosenPlanDuration =
                                arabicPlanTypes.indexOf(v!);
                            await readyPlanProvider.getReadyPlan(
                                planDuration:
                                    readyPlanProvider.chosenPlanDuration,
                                planName: readyPlanProvider
                                    .searchPlanNameController.text);
                            MagicRouter.pop();
                          },
                          valid: (v) {
                            if (v == null) {
                              return 'من فضلك اختر مدة الخطة';
                            } else {
                              return '';
                            }
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomTextField(
                          controller:
                              readyPlanProvider.searchPlanNameController,
                          horizontalPadding: 20.w,
                          hasHint: true,
                          hint: 'ادخل اسم الخطة',
                          hintColor: Colors.black,
                          hintFont: 12.sp,
                          hintWeight: FontWeight.normal,
                          headerTextColor: Colors.black,
                          headerWeight: FontWeight.w400,
                          type: TextInputType.number,
                          valid: (String? v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل اسم الخطة';
                            } else {
                              return null;
                            }
                          },
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

                              await readyPlanProvider.getReadyPlan(
                                  planDuration:
                                      readyPlanProvider.chosenPlanDuration,
                                  planName: readyPlanProvider
                                      .searchPlanNameController.text);

                              MagicRouter.pop();
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Expanded(
                          child: readyPlanProvider.allReadyPlans.isEmpty
                              ? Center(
                                  child: MainText(
                                    text:
                                        'لا يوجد ${arabicPlanTypes[readyPlanProvider.chosenPlanDuration]}',
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  itemCount:
                                      readyPlanProvider.allReadyPlans.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return PlanItem(
                                      readyPlan:
                                          readyPlanProvider.allReadyPlans[i],
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  )
                : RetryWidget(
                    retryCallback: () async {
                      await readyPlanProvider.getReadyPlan(
                        planDuration: readyPlanProvider.chosenPlanDuration,
                        planName:
                            readyPlanProvider.searchPlanNameController.text,
                        retry: true,
                      );
                    },
                  ),
      ),
    );
  }
}
