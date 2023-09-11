import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../../../core/localization/demo_localization.dart';
import '../../../widgets/main_text.dart';
import '../../main_screens/widgets/ticket_item.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.listenFalse(context).getEventCategory();
  }

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.brown,
                    ),
                    child: Center(
                      child: MainText(
                        text: demo.getTranslatedValue('coming'),
                        color: Colors.white,
                        font: 16.sp,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: MainText(
                        text: demo.getTranslatedValue('previous'),
                        color: Colors.black,
                        font: 16.sp,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              MainText(
                text: demo.getTranslatedValue('the_tickets'),
                font: 12.sp,
                weight: FontWeight.w800,
                color: Colors.black,
              ),
              SizedBox(
                height: 16.h,
              ),
              Expanded(
                child: ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                  itemBuilder: (BuildContext context, int i) => TicketItem(),
                  itemCount: 2,
                ),
              ),
            ],
          ),
        ));
  }
}
