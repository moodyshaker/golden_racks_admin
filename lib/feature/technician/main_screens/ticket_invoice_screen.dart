import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/models/search_ticket_model.dart';
import 'package:golden_racks_admin/core/models/ticket_invoice_details_model.dart';
import 'package:golden_racks_admin/core/provider/provider_search_tickets.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/show_spar_parts_screen.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import 'package:golden_racks_admin/feature/widgets/customTextFeild.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class TicketInvoiceScreen extends StatefulWidget {
  final SearchTicketModel searchTicket;
  TicketInvoiceScreen({
    required this.searchTicket,
  });

  @override
  State<TicketInvoiceScreen> createState() => _TicketInvoiceScreenState();
}

class _TicketInvoiceScreenState extends State<TicketInvoiceScreen> {
  TableRow buildRow({
    required List<Widget> cells,
    Color? cellColor,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        color: cellColor ?? gray_20,
      ),
      children: cells.map(
        (e) {
          return Container(
            padding: EdgeInsets.all(10),
            child: e,
          );
        },
      ).toList(),
    );
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
        hasNavBar: false,
        title1: 'الفاتورة للتذكرة\n',
        onBackPressed: () {
          searchTicketProvider.tableList.clear();
          searchTicketProvider.totalPrice = 0;
          searchTicketProvider.totalQuantity = 0;
          searchTicketProvider.invoiceNotesController.clear();
          MagicRouter.pop();
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(0.1),
                    1: FractionColumnWidth(0.4),
                    2: FractionColumnWidth(0.3),
                    3: FractionColumnWidth(0.2),
                  },
                  border: TableBorder.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  children: [
                    buildRow(
                      cellColor: kSecondaryColor,
                      cells: [
                        MainText(
                          textAlign: TextAlign.center,
                          text: 'م',
                          color: Colors.white,
                          font: 14.sp,
                          weight: FontWeight.bold,
                        ),
                        MainText(
                          textAlign: TextAlign.center,
                          text: 'قطع الغيار',
                          color: Colors.white,
                          font: 14.sp,
                          weight: FontWeight.bold,
                        ),
                        MainText(
                          textAlign: TextAlign.center,
                          text: 'الكمية',
                          color: Colors.white,
                          font: 14.sp,
                          weight: FontWeight.bold,
                        ),
                        MainText(
                          textAlign: TextAlign.center,
                          text: 'سعر القطعة',
                          color: Colors.white,
                          font: 14.sp,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    ...searchTicketProvider.tableList.map(
                      (e) => buildRow(
                        cells: [
                          MainText(
                            textAlign: TextAlign.center,
                            text:
                                '${searchTicketProvider.tableList.indexOf(e) + 1}',
                            color: Colors.blue.shade900,
                            weight: FontWeight.bold,
                            font: 14.sp,
                          ),
                          MainText(
                            textAlign: TextAlign.center,
                            text: '${e.title}',
                            color: Colors.blue.shade900,
                            weight: FontWeight.bold,
                            font: 14.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 17.h,
                                width: 17.h,
                                decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  child: Icon(
                                    Icons.add,
                                    size: 10,
                                    color: kAccentColor,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      e.quantity++;
                                      searchTicketProvider.totalQuantity++;
                                      searchTicketProvider.totalPrice +=
                                          e.price;
                                    });
                                  },
                                ),
                              ),
                              MainText(
                                textAlign: TextAlign.center,
                                text: '${e.quantity}',
                                color: Colors.blue.shade900,
                                weight: FontWeight.bold,
                                font: 14.sp,
                              ),
                              Container(
                                height: 17.h,
                                width: 17.h,
                                decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  child: Icon(
                                    Icons.remove,
                                    size: 10,
                                    color: kAccentColor,
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        if (e.quantity > 0) {
                                          e.quantity--;
                                          searchTicketProvider.totalQuantity--;
                                          searchTicketProvider.totalPrice -=
                                              e.price;
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          MainText(
                            textAlign: TextAlign.center,
                            text: '${(e.price * e.quantity).toDouble()}',
                            color: Colors.blue.shade900,
                            weight: FontWeight.bold,
                            font: 14.sp,
                          ),
                        ],
                      ),
                    ),
                    buildRow(
                      cells: [
                        MainText(
                          textAlign: TextAlign.center,
                          text: '',
                          color: Colors.blue.shade900,
                          weight: FontWeight.bold,
                          font: 14.sp,
                        ),
                        InkWell(
                          child: MainText(
                            textAlign: TextAlign.center,
                            text: 'اضف هنا قطعة غيار',
                            color: Colors.blue.shade900,
                            weight: FontWeight.w900,
                            font: 14.sp,
                            decoration: TextDecoration.underline,
                          ),
                          onTap: () {
                            MagicRouter.navigateTo(ShowSparPartsScreen(
                              searchTicket: widget.searchTicket,
                            ));
                          },
                        ),
                        MainText(
                          textAlign: TextAlign.center,
                          text: '',
                          color: Colors.blue.shade900,
                          weight: FontWeight.bold,
                          font: 14.sp,
                        ),
                        MainText(
                          textAlign: TextAlign.center,
                          text: '',
                          color: Colors.blue.shade900,
                          weight: FontWeight.bold,
                          font: 14.sp,
                        ),
                      ],
                    ),
                    buildRow(
                      cellColor: kSecondaryColor,
                      cells: [
                        MainText(
                          textAlign: TextAlign.center,
                          text: '',
                          color: Colors.white,
                          font: 14.sp,
                          weight: FontWeight.bold,
                        ),
                        MainText(
                          textAlign: TextAlign.center,
                          text: 'الاجمالي',
                          color: Colors.white,
                          font: 14.sp,
                          weight: FontWeight.bold,
                        ),
                        MainText(
                          textAlign: TextAlign.center,
                          text: '${searchTicketProvider.totalQuantity}',
                          color: Colors.white,
                          font: 14.sp,
                          weight: FontWeight.bold,
                        ),
                        MainText(
                          textAlign: TextAlign.center,
                          text: '${searchTicketProvider.totalPrice}',
                          color: Colors.white,
                          font: 14.sp,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              widget.searchTicket.readyPlanDetails!.isEmpty
                  ? Container()
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                            textAlign: TextAlign.right,
                            text:
                                'الشركة علي ${arabicPlanTypes[englishPlanTypes.indexOf(widget.searchTicket.readyPlanDetails![0].readyPlanName!)]}',
                            font: 16.sp,
                            color: Colors.black,
                            weight: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              MainText(
                                textAlign: TextAlign.right,
                                text: 'ولديها الان  ',
                                font: 14.sp,
                                color: Colors.black,
                              ),
                              MainText(
                                textAlign: TextAlign.right,
                                text:
                                    '${widget.searchTicket.readyPlanDetails![0].numberOfFixedVisit}',
                                font: 14.sp,
                                color: Colors.red,
                                weight: FontWeight.bold,
                              ),
                              MainText(
                                textAlign: TextAlign.right,
                                text: '  زيارات دورية و  ',
                                font: 14.sp,
                                color: Colors.black,
                              ),
                              MainText(
                                textAlign: TextAlign.right,
                                text:
                                    '${widget.searchTicket.readyPlanDetails![0].numberOfEmeregencyVisit}',
                                font: 14.sp,
                                color: Colors.red,
                                weight: FontWeight.bold,
                              ),
                              MainText(
                                textAlign: TextAlign.right,
                                text: '  زيارات طوارئ',
                                font: 14.sp,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          MainText(
                            textAlign: TextAlign.right,
                            text: 'ولديها ايضا تزييت مجاني',
                            font: 14.sp,
                            color: Colors.black,
                          ),
                          // MainText(
                          //   textAlign: TextAlign.right,
                          //   text: 'ولديها 0 قطع مجانية',
                          //   font: 14.sp,
                          //   color: Colors.black,
                          // ),
                        ],
                      ),
                    ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: MainText(
                        text: 'ملاحظات اخري',
                        color: Colors.black,
                        font: 16.sp,
                        weight: FontWeight.w400,
                      ),
                    ),
                    CustomTextField(
                      controller: searchTicketProvider.invoiceNotesController,
                      horizontalPadding: 20.w,
                      verticalPadding: 10.h,
                      minLines: 8,
                      hasHeader: false,
                      hasHint: false,
                      type: TextInputType.text,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomButton(
                      title: 'حفظ الفاتورة',
                      color: kSecondaryColor,
                      height: 50.h,
                      font: 16.sp,
                      family: 'Lato_bold',
                      textColor: Colors.white,
                      withBorder: false,
                      onPressed: () async {
                        await searchTicketProvider.addTicketInvoice(
                          ticketNumber:
                              widget.searchTicket.completeTicketNumber!,
                          technicalId: widget.searchTicket.technicalId!,
                          companyId: widget.searchTicket.companyId!,
                          dailyTaskReturnTypeId:
                              widget.searchTicket.dailyTaskReturnTypeId!,
                          dailyTaskReturnTypeName:
                              widget.searchTicket.dailyTaskReturnTypeName!,
                          problemName: widget.searchTicket.problemName!,
                          readyPlanName:
                              widget.searchTicket.readyPlanDetails!.isEmpty
                                  ? ''
                                  : widget.searchTicket.readyPlanDetails![0]
                                      .readyPlanName!,
                          note:
                              searchTicketProvider.invoiceNotesController.text,
                          addTicketInvoiceDetailsRquestDtos:
                              searchTicketProvider.tableList
                                  .map(
                                    (e) => AddTicketInvoiceDetailsRquestDtos(
                                      subsribeId: e.subscribeId,
                                      sparePartId: e.id,
                                      sparePartPrice: e.price,
                                      quantity: e.quantity,
                                      numberOPaiedQuantity: 0,
                                      numberOfFreeQuantity: 0,
                                    ),
                                  )
                                  .toList(),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
