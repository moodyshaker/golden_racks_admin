import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/models/subscribed_company_model.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/subscribed_companies_admin/send_alert_to_company_screen.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';

class CompanyViewScreen extends StatefulWidget {
  final SubscribedCompanyModel subscribedCompany;

  const CompanyViewScreen({required this.subscribedCompany});
  @override
  State<CompanyViewScreen> createState() => _CompanyViewScreenState();
}

class _CompanyViewScreenState extends State<CompanyViewScreen> {
  @override
  Widget build(BuildContext context) {
    TableRow buildRow({required List<String> cells}) {
      return TableRow(
        children: cells.map(
          (e) {
            return Container(
              padding: EdgeInsets.all(10),
              child: MainText(
                text: e,
                font: 16.sp,
                weight: FontWeight.bold,
              ),
            );
          },
        ).toList(),
      );
    }

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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Container(
                  height: 56.h,
                  width: 200.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.w, horizontal: 30.h),
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
                          getAsset('edit_icon'),
                          color: gray_40,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      MainText(
                        text: 'تعديل',
                        color: Colors.white,
                        font: 16.sp,
                        weight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  title: '${widget.subscribedCompany.companyName}',
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
                SizedBox(height: 8.h),
                Container(
                  color: gray_0,
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(
                          width: 1,
                          color: gray_40,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        children: [
                          buildRow(
                            cells: [
                              'اسم الشركة',
                              '${widget.subscribedCompany.companyName}'
                            ],
                          ),
                          buildRow(
                            cells: [
                              'اسم المستخدم',
                              '${widget.subscribedCompany.userName}'
                            ],
                          ),
                          buildRow(
                            cells: [
                              'البريد الالكتروني',
                              '${widget.subscribedCompany.email}'
                            ],
                          ),
                          buildRow(
                            cells: [
                              'رقم الجوال',
                              '${widget.subscribedCompany.mobileNumber}'
                            ],
                          ),
                          buildRow(
                            cells: [
                              'الخطة',
                              '${arabicPlanTypes[englishPlanTypes.indexOf(
                                    '${widget.subscribedCompany.subscriptionsForThisCompanies![0].planType}',
                                  )]}' +
                                  '\nبداية من تاريخ' +
                                  '\n${formateDateTimeToDate(widget.subscribedCompany.subscriptionsForThisCompanies![0].startDate!)}' +
                                  '\nحتي' +
                                  '\n${formateDateTimeToDate(widget.subscribedCompany.subscriptionsForThisCompanies![0].endDate!)}'
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'ارسال اشعار',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          MagicRouter.navigateTo(SendAlertToCompanyAdminScreen(
                            subscribedCompany: widget.subscribedCompany,
                          ));
                        },
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            alignment: Alignment.center,
                            child: Text(
                              'الخطط المشترك بها',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SubscribedPlanWidget(
                                subscribedCompany: widget.subscribedCompany,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                'عدد الزيارات',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return FixedVisitsWidget(
                                subscribedCompany: widget.subscribedCompany,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'عدد المفاجأة',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return EmergencyVisitsWidget(
                                subscribedCompany: widget.subscribedCompany,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 4.w),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(width: 1.0, color: mainColor),
                  ),
                  child: Center(
                    child: MainText(
                      text: 'عرض نشاط جدول الخطة للصيانة',
                      font: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubscribedPlanWidget extends StatelessWidget {
  final SubscribedCompanyModel subscribedCompany;

  const SubscribedPlanWidget({required this.subscribedCompany});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: gray_40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, i) {
          return SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                margin: EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(width: 1.0, color: kInactiveColor),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'الخطة المفعلة',
                          font: 15.sp,
                          color: Colors.white,
                          weight: FontWeight.w700,
                        ),
                        Flexible(
                          child: MainText(
                            text: '${arabicPlanTypes[englishPlanTypes.indexOf(
                              '${subscribedCompany.subscriptionsForThisCompanies![i].planType}',
                            )]}',
                            font: 15.sp,
                            color: Colors.white,
                            weight: FontWeight.w700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Divider(
                        color: gray_40,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'التاريخ',
                          font: 15.sp,
                          color: Colors.white,
                          weight: FontWeight.w700,
                        ),
                        Flexible(
                          child: MainText(
                            text: 'من ${formateDateTimeToDate(subscribedCompany.subscriptionsForThisCompanies![i].startDate!)}' +
                                '\nالي ' +
                                '${formateDateTimeToDate(subscribedCompany.subscriptionsForThisCompanies![i].endDate!)}',
                            font: 15.sp,
                            color: Colors.white,
                            weight: FontWeight.w700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: subscribedCompany.subscriptionsForThisCompanies!.length,
      ),
    );
  }
}

class EmergencyVisitsWidget extends StatelessWidget {
  final SubscribedCompanyModel subscribedCompany;

  EmergencyVisitsWidget({required this.subscribedCompany});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: gray_40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, i) {
          return SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                margin: EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(width: 1.0, color: kInactiveColor),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'الخطة المفعلة',
                          font: 15.sp,
                          color: Colors.white,
                          weight: FontWeight.w700,
                        ),
                        Flexible(
                          child: MainText(
                            text: '${arabicPlanTypes[englishPlanTypes.indexOf(
                              '${subscribedCompany.subscriptionsForThisCompanies![i].planType}',
                            )]}',
                            font: 15.sp,
                            color: Colors.white,
                            weight: FontWeight.w700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Divider(
                        color: gray_40,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'عدد الزيارات المفاجأة',
                          font: 15.sp,
                          color: Colors.white,
                          weight: FontWeight.w700,
                        ),
                        Flexible(
                          child: MainText(
                            text:
                                '${subscribedCompany.subscriptionsForThisCompanies![i].numberOEmregencyVisits}',
                            font: 15.sp,
                            color: Colors.white,
                            weight: FontWeight.w700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Divider(
                        color: gray_40,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'التاريخ',
                          font: 15.sp,
                          color: Colors.white,
                          weight: FontWeight.w700,
                        ),
                        Flexible(
                          child: MainText(
                            text: 'من ${formateDateTimeToDate(subscribedCompany.subscriptionsForThisCompanies![i].startDate!)}' +
                                '\nالي ' +
                                '${formateDateTimeToDate(subscribedCompany.subscriptionsForThisCompanies![i].endDate!)}',
                            font: 15.sp,
                            color: Colors.white,
                            weight: FontWeight.w700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: subscribedCompany.subscriptionsForThisCompanies!.length,
      ),
    );
  }
}

class FixedVisitsWidget extends StatelessWidget {
  final SubscribedCompanyModel subscribedCompany;

  FixedVisitsWidget({required this.subscribedCompany});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: gray_40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, i) {
          return SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                margin: EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(width: 1.0, color: kInactiveColor),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'الخطة المفعلة',
                          font: 15.sp,
                          color: Colors.white,
                          weight: FontWeight.w700,
                        ),
                        Flexible(
                          child: MainText(
                            text: '${arabicPlanTypes[englishPlanTypes.indexOf(
                              '${subscribedCompany.subscriptionsForThisCompanies![i].planType}',
                            )]}',
                            font: 15.sp,
                            color: Colors.white,
                            weight: FontWeight.w700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Divider(
                        color: gray_40,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'عدد الزيارات الثابتة',
                          font: 15.sp,
                          color: Colors.white,
                          weight: FontWeight.w700,
                        ),
                        Flexible(
                          child: MainText(
                            text:
                                '${subscribedCompany.subscriptionsForThisCompanies![i].numberOfFixedVisits}',
                            font: 15.sp,
                            color: Colors.white,
                            weight: FontWeight.w700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Divider(
                        color: gray_40,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'التاريخ',
                          font: 15.sp,
                          color: Colors.white,
                          weight: FontWeight.w700,
                        ),
                        Flexible(
                          child: MainText(
                            text: 'من ${formateDateTimeToDate(subscribedCompany.subscriptionsForThisCompanies![i].startDate!)}' +
                                '\nالي ' +
                                '${formateDateTimeToDate(subscribedCompany.subscriptionsForThisCompanies![i].endDate!)}',
                            font: 15.sp,
                            color: Colors.white,
                            weight: FontWeight.w700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: subscribedCompany.subscriptionsForThisCompanies!.length,
      ),
    );
  }
}
