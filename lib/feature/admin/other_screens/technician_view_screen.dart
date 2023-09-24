import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_add_technation.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_technician_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/technician_item.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import '../../../../constants.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';

class TechnicianViewScreen extends StatefulWidget {
  const TechnicianViewScreen({Key? key}) : super(key: key);

  @override
  State<TechnicianViewScreen> createState() => _TechnicianViewScreenState();
}

class _TechnicianViewScreenState extends State<TechnicianViewScreen> {
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
        title1: 'انشاء حسابات الدخول للفنين',
        body: addTechProvider.techStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : addTechProvider.techStatus == NetworkStatus.success
                ? SingleChildScrollView(
                    child: Container(
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
                                  vertical: 10.w, horizontal: 30.h),
                              margin: EdgeInsets.only(bottom: 8.h),
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
                            height: 200.h,
                            child: addTechProvider.allTechnicals.isEmpty
                                ? MainText(
                                    text: 'لا يوجد فني بهذا الاسم',
                                  )
                                : ListView.builder(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    itemBuilder: (BuildContext context, int i) {
                                      return TechnicianItem(
                                        tech: addTechProvider.allTechnicals[i],
                                      );
                                    },
                                    itemCount:
                                        addTechProvider.allTechnicals.length,
                                  ),
                          ),
                          SizedBox(
                            height: 27.h,
                          ),
                          CustomButton(
                            title: 'عرض تقرير الزيارات اليومي',
                            color: kSecondaryColor,
                            height: 50.h,
                            font: 16.sp,
                            family: 'Lato_bold',
                            textColor: Colors.white,
                            withBorder: false,
                            onPressed: () async {},
                          ),
                          SizedBox(height: 16.h)
                        ],
                      ),
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
    );
  }
}
