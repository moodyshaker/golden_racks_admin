// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/profile_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_profile.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';

class TechProfileScreen extends StatefulWidget {
  final String techId;

  TechProfileScreen({
    required this.techId,
  });

  @override
  State<TechProfileScreen> createState() => _TechProfileScreenState();
}

class _TechProfileScreenState extends State<TechProfileScreen> {
  @override
  void initState() {
    super.initState();
    ProfileProvider.listenFalse(context).getProfileData(
      userId: widget.techId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = ProfileProvider.get(context);
    ProfileModel profile = profileProvider.profileData;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            getAsset('background1'),
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: OrganizerCustomScaffold(
        backgroundColor: Colors.transparent,
        isHome: true,
        hasAppbar: true,
        title1: '',
        title2: '',
        title3: '',
        pic: 'icon_background',
        hasNavBar: true,
        body: profileProvider.getProfileStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : profileProvider.getProfileStatus == NetworkStatus.success
                ? Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: Preferences.instance.getUserImage == ''
                                ? null
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: Image.network(
                                            '${base_url_image}${Preferences.instance.getUserImage}',
                                          ),
                                        );
                                      },
                                    );
                                  },
                            child: Container(
                              height: 122.h,
                              width: 122.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: kSecondaryColor,
                                  width: 2.0,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Preferences.instance.getUserImage == ''
                                      ? Image.asset(
                                          getAsset('icon_background'),
                                        ).image
                                      : Image.network(
                                          '${base_url_image}${Preferences.instance.getUserImage}',
                                        ).image,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24.w),
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileDataItemWidget(
                                  head: 'اسم المستخدم',
                                  title: '${profile.userName}',
                                ),
                                ProfileDataItemWidget(
                                  head: 'الاسم الكامل',
                                  title: '${profile.fullName}',
                                ),
                                ProfileDataItemWidget(
                                  head: 'رقم الجوال',
                                  title: '${profile.mobileNumber}',
                                ),
                                ProfileDataItemWidget(
                                  head: 'رقم ثابت',
                                  title: '${profile.fixedNumber}',
                                ),
                                ProfileDataItemWidget(
                                  head: 'البريد الالكتروني',
                                  title: '${profile.email}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : RetryWidget(
                    retryCallback: () async {
                      await profileProvider.getProfileData(
                        userId: Preferences.instance.getUserId,
                        retry: true,
                      );
                    },
                  ),
      ),
    );
  }
}

class ProfileDataItemWidget extends StatelessWidget {
  final String head;
  final String title;
  ProfileDataItemWidget({
    required this.head,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainText(
          text: head,
          weight: FontWeight.w800,
          font: 14.sp,
        ),
        SizedBox(height: 4.h),
        MainText(
          text: title,
          font: 12.sp,
        ),
        Divider(
          thickness: 1,
          color: gray_60,
          height: 12.h,
        )
      ],
    );
  }
}
