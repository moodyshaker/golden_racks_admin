import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants.dart';
import '../../../../core/bloc/organizer_app_cubit.dart';
import '../../../../core/localization/demo_localization.dart';
import '../../../widgets/main_text.dart';

class OrganizerMain extends StatefulWidget {
  const OrganizerMain({Key? key}) : super(key: key);

  @override
  State<OrganizerMain> createState() => _OrganizerMainState();
}

class _OrganizerMainState extends State<OrganizerMain> {

  @override
  void initState() {
    super.initState();
    OrganizerAppCubit.listenFalse(context).getOrganizerEventList(OrganizerAppCubit().status);
  }

  @override
  Widget build(BuildContext context) {
    final DemoLocalization demo = DemoLocalization.of(context);
    final OrganizerAppCubit organizer = OrganizerAppCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText(
                      text: demo.getTranslatedValue('activated_plans'),
                      font: 12.sp,
                      weight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    SizedBox(height: 16.h,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.w , horizontal: 25.h),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(getAsset('plan_background')),
                              fit: BoxFit.fill
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                            text: demo.getTranslatedValue('free_plan_after_purchase'),
                            font: 16.sp,
                            weight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          SizedBox(height: 13.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: MainText(
                                  text: demo.getTranslatedValue('activation_date'),
                                  font: 12.sp,
                                  weight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: MainText(
                                  text: demo.getTranslatedValue('expiry_date'),
                                  font: 12.sp,
                                  weight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(getAsset('item_background')),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10.h,),
                                        MainText(
                                          text: demo.getTranslatedValue('regular_visits'),
                                          font: 8.sp,
                                          weight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                        MainText(
                                          text: demo.getTranslatedValue('visits_left'),
                                          font: 8.sp,
                                          weight: FontWeight.w300,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(getAsset('item_background')),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10.h,),
                                        MainText(
                                          text: demo.getTranslatedValue('emergency_visits'),
                                          font: 8.sp,
                                          weight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                        MainText(
                                          text: demo.getTranslatedValue('visits_left'),
                                          font: 8.sp,
                                          weight: FontWeight.w300,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                      child: Image.asset(
                                          getAsset('ic_ticket_black')
                                      ),
                                    height: 22.sp,
                                    width: 36.sp,
                                  ),
                                  MainText(
                                    text: demo.getTranslatedValue('visits'),
                                    font: 12.sp,
                                    weight: FontWeight.w200,
                                  ),
                                ],
                              ),
                              MainText(
                                text: demo.getTranslatedValue('plan_modification'),
                                font: 12.sp,
                                weight: FontWeight.w200,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h,),
                    MainText(
                      text: demo.getTranslatedValue('plans'),
                      font: 12.sp,
                      weight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10.h,),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(getAsset('plan_background')),
                                fit: BoxFit.fill
                            )
                        ),
                        height: 150.h,
                        width: double.infinity,
                        child: Center(
                          child: MainText(
                            text: demo.getTranslatedValue('add_a_new_plan'),
                            font: 12.sp,
                            weight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(getAsset('blue_card')),
                                      fit: BoxFit.fill
                                  )
                              ),
                              height: 150.h,
                              child: Center(
                                child: MainText(
                                  text: demo.getTranslatedValue('emergency_request'),
                                  color: Colors.white,
                                  font: 12.sp,
                                  weight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w,),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(getAsset('orange_card')),
                                      fit: BoxFit.fill
                                  )
                              ),
                              height: 150.h,
                              child: Center(
                                child: MainText(
                                  text: demo.getTranslatedValue('request_a_regular_visit'),
                                  font: 12.sp,
                                  weight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
          ],
        )
    );
  }
}
