// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:golden_racks_admin/core/models/search_ticket_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_search_tickets.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/widgets/spar_part_item.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';

import '../../../../constants.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';

class ShowSparPartsScreen extends StatefulWidget {
  final SearchTicketModel searchTicket;
  ShowSparPartsScreen({
    required this.searchTicket,
  });

  @override
  State<ShowSparPartsScreen> createState() => _ShowSparPartsScreenState();
}

class _ShowSparPartsScreenState extends State<ShowSparPartsScreen> {
  @override
  void initState() {
    super.initState();
    SearchTicketProvider.listenFalse(context).getSpareParts(name: '');
  }

  @override
  Widget build(BuildContext context) {
    final searchTicketProvider = SearchTicketProvider.get(context);
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
        title1: 'اختر قطعة الغيار',
        body: searchTicketProvider.sparePartStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : searchTicketProvider.sparePartStatus == NetworkStatus.success
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          child: CustomTextField(
                            controller:
                                searchTicketProvider.sparePartSearchController,
                            borderColor: mainColor,
                            hint: 'ابحث عن قطعة غيار',
                            horizontalPadding: 16.w,
                            suffixIcon: InkWell(
                              child: Container(
                                width: 60.w,
                                child: Center(
                                  child: Container(
                                    height: 32.h,
                                    width: 32.w,
                                    child: Image.asset(getAsset('search_icon')),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => LoadingDialog(),
                                );
                                await searchTicketProvider.getSpareParts(
                                  name: searchTicketProvider
                                      .sparePartSearchController.text,
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
                        searchTicketProvider.allSpareParts.isEmpty
                            ? Center(
                                child: MainText(
                                  text: 'لا يوجد قطع غيار',
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  itemBuilder: (BuildContext context, int i) =>
                                      SparPartItem(
                                    sparePart:
                                        searchTicketProvider.allSpareParts[i],
                                    searchTicket: widget.searchTicket,
                                  ),
                                  itemCount:
                                      searchTicketProvider.allSpareParts.length,
                                ),
                              ),
                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    ),
                  )
                : RetryWidget(retryCallback: () async {
                    await searchTicketProvider.getSpareParts(
                      name: 'name',
                      retry: true,
                    );
                  }),
      ),
    );
  }
}
