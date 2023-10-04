// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/models/search_ticket_model.dart';
import 'package:golden_racks_admin/core/provider/provider_search_tickets.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import 'package:golden_racks_admin/feature/widgets/customTextFeild.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class TechnicalReportScreen extends StatefulWidget {
  final SearchTicketModel searchTicket;

  TechnicalReportScreen({
    required this.searchTicket,
  });

  @override
  State<TechnicalReportScreen> createState() => _TechnicalReportScreenState();
}

class _TechnicalReportScreenState extends State<TechnicalReportScreen> {
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
          title1: 'التقرير الفني',
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
                    text: 'قم بكتابة ملاحظاتك',
                    color: Colors.black,
                    font: 16.sp,
                    weight: FontWeight.w400,
                  ),
                  CustomTextField(
                    controller:
                        searchTicketProvider.addTechnicalReportController,
                    horizontalPadding: 20.w,
                    verticalPadding: 10.h,
                    minLines: 16,
                    hasHeader: false,
                    hasHint: false,
                    type: TextInputType.text,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomButton(
                    title: 'حفظ التقرير',
                    color: kSecondaryColor,
                    height: 50.h,
                    font: 16.sp,
                    family: 'Lato_bold',
                    textColor: Colors.white,
                    withBorder: false,
                    onPressed: () async {
                      await searchTicketProvider.addTechnicalReport(
                        TechnicalId: widget.searchTicket.technicalId!,
                        CompanyId: widget.searchTicket.companyId!,
                        TicketNumber: widget.searchTicket.completeTicketNumber!,
                        SubscriptionId: widget.searchTicket.subscribeId!,
                        ReportMessage: searchTicketProvider
                            .addTechnicalReportController.text,
                        dailyTaskReturnTypeId:
                            widget.searchTicket.dailyTaskReturnTypeId!,
                        dailyTaskReturnTypeName:
                            widget.searchTicket.dailyTaskReturnTypeName!,
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
