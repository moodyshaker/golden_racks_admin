import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/widgets/spar_part_item.dart';

import '../../../../constants.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';

class ShowSparPartsScreen extends StatefulWidget {
  const ShowSparPartsScreen({Key? key}) : super(key: key);

  @override
  State<ShowSparPartsScreen> createState() => _ShowSparPartsScreenState();
}

class _ShowSparPartsScreenState extends State<ShowSparPartsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title1: 'اختر قطعة الغيار',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: CustomTextField(
                  borderColor: mainColor,
                  hint: 'ابحث عن قطعة غيار',
                  horizontalPadding: 16.w,
                  suffixIcon: Container(
                    width: 60.w,
                    child: Center(
                        child: Container(
                      height: 32.h,
                      width: 32.w,
                      child: Image.asset(getAsset('search_icon')),
                    )),
                  ),
                  hasHint: true,
                  suffixCallback: () {},
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 235.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  itemBuilder: (BuildContext context, int i) => SparPartItem(),
                  itemCount: 4,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
