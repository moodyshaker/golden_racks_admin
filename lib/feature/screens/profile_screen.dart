import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/profile_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_profile.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/screens/edit_profile_screen.dart';
import 'package:golden_racks_admin/feature/screens/reset_password_screen.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    ProfileProvider.listenFalse(context).getProfileData(
      userId: Preferences.instance.getUserId,
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
      child: isAdmin!
          ? OrganizerCustomScaffold(
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
                      ? _screen(context, profile)
                      : RetryWidget(
                          retryCallback: () async {
                            await profileProvider.getProfileData(
                              userId: Preferences.instance.getUserId,
                              retry: true,
                            );
                          },
                        ),
            )
          : TechnicianCustomScaffold(
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
                      ? _screen(context, profile)
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

  Container _screen(BuildContext context, ProfileModel profile) {
    return Container(
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
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      color: Colors.brown,
                    ),
                    child: MainText(
                      text: 'تعديل بيانات الحساب',
                      textAlign: TextAlign.center,
                      color: Colors.white,
                      font: 12.sp,
                      weight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    MagicRouter.navigateTo(EditProfileScreen(
                      profileModel: profile,
                    ));
                  },
                ),
                InkWell(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      color: Colors.brown,
                    ),
                    child: MainText(
                      text: 'تعديل كلمة المرور',
                      textAlign: TextAlign.center,
                      color: Colors.white,
                      font: 12.sp,
                      weight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    MagicRouter.navigateTo(ResetPasswordScreen());
                  },
                ),
              ],
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
