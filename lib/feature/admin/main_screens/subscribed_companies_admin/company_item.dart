import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/models/subscribed_company_model.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/subscribed_companies_admin/company_view_screen.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

class CompanyItem extends StatefulWidget {
  final SubscribedCompanyModel subscribedCompany;

  const CompanyItem({required this.subscribedCompany});

  @override
  State<CompanyItem> createState() => _CompanyItemState();
}

class _CompanyItemState extends State<CompanyItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MagicRouter.navigateTo(CompanyViewScreen(
          subscribedCompany: widget.subscribedCompany,
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.h),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: gray_0,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(width: 1.0, color: gray_10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainText(
              text: '${widget.subscribedCompany.companyName}',
              font: 15.sp,
              color: Colors.black,
              weight: FontWeight.w500,
              family: 'Lato',
            ),
            InkWell(
              child: Container(
                height: 28.h,
                width: 28.w,
                child: Image.asset(
                  getAsset('eyes_icon'),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
