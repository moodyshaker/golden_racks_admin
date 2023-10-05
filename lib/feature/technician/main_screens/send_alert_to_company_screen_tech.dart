// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/models/search_ticket_model.dart';
import 'package:golden_racks_admin/core/provider/provider_search_tickets.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import 'package:golden_racks_admin/feature/widgets/customTextFeild.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class SendAlertToCompanyTechScreen extends StatefulWidget {
  final SearchTicketModel searchTicket;
  SendAlertToCompanyTechScreen({
    required this.searchTicket,
  });

  @override
  State<SendAlertToCompanyTechScreen> createState() =>
      _SendAlertToCompanyTechScreenState();
}

class _SendAlertToCompanyTechScreenState
    extends State<SendAlertToCompanyTechScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchTicketProvider = SearchTicketProvider.get(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background2')),
          fit: BoxFit.fill,
        ),
      ),
      child: TechnicianCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: false,
        isHome: true,
        hasNavBar: true,
        title1: 'ارسال تنبيه للشركة',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                MainText(
                  text: 'قم بكتابة التنبيه',
                  color: Colors.black,
                  font: 16.sp,
                  weight: FontWeight.w400,
                ),
                CustomTextField(
                  horizontalPadding: 20.w,
                  controller: searchTicketProvider.sendAlertToCompanyController,
                  minLines: 10,
                  hasHeader: false,
                  hasHint: true,
                  hint: 'مثال . انا قادم اليوم الساعة , يجب تجهيز كذا',
                  hintWeight: FontWeight.w600,
                  hintColor: gray_60,
                  hintFont: 16.sp,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomButton(
                  title: 'ارسال التنبيه للشركة',
                  color: kSecondaryColor,
                  height: 50.h,
                  font: 16.sp,
                  family: 'Lato_bold',
                  textColor: Colors.white,
                  withBorder: false,
                  onPressed: () async {
                    await searchTicketProvider.sendAlertToCompany(
                      SenderId: Preferences.instance.getUserId,
                      ReceiverId: widget.searchTicket.companyId!,
                      Message: searchTicketProvider
                          .sendAlertToCompanyController.text,
                    );
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
