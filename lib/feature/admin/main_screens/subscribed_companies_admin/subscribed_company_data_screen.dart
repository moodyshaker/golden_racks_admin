import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_subscribed_Company.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/subscribed_companies_admin/company_item.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_company_with_plan_screen.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';

import '../../../../../constants.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/customTextFeild.dart';
import '../../../widgets/organizerCustomScaffold.dart';

class SubscribedCompanyDataScreen extends StatefulWidget {
  const SubscribedCompanyDataScreen({Key? key}) : super(key: key);

  @override
  State<SubscribedCompanyDataScreen> createState() =>
      _SubscribedCompanyDataScreenState();
}

class _SubscribedCompanyDataScreenState
    extends State<SubscribedCompanyDataScreen> {
  @override
  void initState() {
    SubscribedCompanyProvider.listenFalse(context)
        .getSubscribedCompanies(companyName: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final companyProvider = SubscribedCompanyProvider.get(context);

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
        hasNavBar: false,
        title1: 'بيانات الشركات المشتركة',
        body: companyProvider.getCompaniesStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : companyProvider.getCompaniesStatus == NetworkStatus.success
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            log('from shareCompanyDataScreen');

                            MagicRouter.navigateTo(
                              AddCompanyWithPlanScreen(),
                            );
                          },
                          child: Container(
                            height: 56.h,
                            width: 200.h,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.w, horizontal: 30.h),
                            margin: EdgeInsets.only(bottom: 8.h),
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(width: 1.0, color: mainColor),
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
                                  text: 'اضافة شركة',
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
                            controller: companyProvider.companyNameController,
                            borderColor: mainColor,
                            hint: 'ابحث عن شركة',
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
                                await companyProvider.getSubscribedCompanies(
                                  companyName:
                                      '${companyProvider.companyNameController.text}',
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
                          title: 'اسم الشركة',
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
                        companyProvider.allSubscribedCompanies.isEmpty
                            ? MainText(
                                text: 'لا توجد شركة بهذا الاسم',
                              )
                            : Container(
                                height: 235.h,
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  itemBuilder: (BuildContext context, int i) =>
                                      CompanyItem(
                                    subscribedCompany: companyProvider
                                        .allSubscribedCompanies[i],
                                  ),
                                  itemCount: companyProvider
                                      .allSubscribedCompanies.length,
                                ),
                              ),
                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    ),
                  )
                : RetryWidget(
                    retryCallback: () {
                      companyProvider.getSubscribedCompanies(
                        companyName: '',
                        retry: true,
                      );
                    },
                  ),
      ),
    );
  }
}
