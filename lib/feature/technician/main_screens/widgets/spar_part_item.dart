import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/search_ticket_model.dart';

import 'package:golden_racks_admin/core/models/spare_part_model.dart';
import 'package:golden_racks_admin/core/models/table_object_model.dart';
import 'package:golden_racks_admin/core/provider/provider_search_tickets.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/widgets/action_dialog.dart';

import '../../../../constants.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class SparPartItem extends StatefulWidget {
  final SparePartModel sparePart;
  final SearchTicketModel searchTicket;

  SparPartItem({
    required this.sparePart,
    required this.searchTicket,
  });

  @override
  State<SparPartItem> createState() => _SparPartItemState();
}

class _SparPartItemState extends State<SparPartItem> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final searchTicketProvider = SearchTicketProvider.get(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.h),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(
                  text: '${widget.sparePart.name}',
                  font: 15.sp,
                  color: Colors.black,
                  weight: FontWeight.w500,
                  family: 'Lato',
                ),
                Container(
                  height: 28.h,
                  width: 28.w,
                  child: Image.asset(
                    getAsset('eyes_icon'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          CustomButton(
            title: 'اضافة',
            width: 90.w,
            color: mainColor,
            font: 15.sp,
            radius: 8.r,
            family: 'Lato_bold',
            weight: FontWeight.w800,
            textColor: Colors.white,
            withBorder: false,
            onPressed: () async {
              if (searchTicketProvider.tableList
                  .where((e) => e.id == widget.sparePart.id!)
                  .toList()
                  .isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (_) => ActionDialog(
                    content: 'قطعة الغيار موجودة بالفعل',
                    approveAction: 'حسنا',
                    onApproveClick: MagicRouter.pop,
                  ),
                );
              } else {
                print(
                    '${widget.sparePart.name} // ${widget.sparePart.sellingPrice}');
                searchTicketProvider.addTableToList(
                  data: TableObject(
                    id: widget.sparePart.id!,
                    title: widget.sparePart.name!,
                    price: widget.sparePart.sellingPrice!,
                    subscribeId: widget.searchTicket.subscribeId!,
                  ),
                );

                searchTicketProvider.totalPrice +=
                    widget.sparePart.sellingPrice!;
                searchTicketProvider.totalQuantity++;

                MagicRouter.pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
