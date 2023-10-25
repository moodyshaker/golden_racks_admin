import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/localization/demo_localization.dart';
import 'package:golden_racks_admin/core/models/country_model.dart' as c;

import 'package:golden_racks_admin/core/models/profile_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_auth.dart';
import 'package:golden_racks_admin/core/provider/provider_profile.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import 'package:golden_racks_admin/feature/widgets/customTextFeild.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileModel profileModel;
  EditProfileScreen({
    required this.profileModel,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool firstCountry = true;

  c.Country? selectedCountry;
  c.City? selectedCity;
  c.State? selectedState;

  String? selectedCountryValue;
  String? selectedCityValue;
  String? selectedStateValue;

  @override
  void initState() {
    super.initState();
    AuthProvider.listenFalse(context).getAllCountries();

    ProfileProvider.listenFalse(context).selectedProfileImage = null;

    var profile = ProfileProvider.listenFalse(context);

    profile.profileFullNameController.text = widget.profileModel.fullName ?? '';
    profile.profileMobileNumberController.text =
        widget.profileModel.mobileNumber ?? '';
    profile.profileFixedNumberController.text =
        widget.profileModel.fixedNumber ?? '';
    profile.profileCompanyName_ArController.text =
        widget.profileModel.companyNameAr ?? '';
    profile.profileCompanyName_EnController.text =
        widget.profileModel.companyNameEn ?? '';
    profile.profileTaxNumberController.text =
        widget.profileModel.taxNumber ?? '';
    profile.profileStreetController.text = widget.profileModel.street ?? '';
    profile.profileBuildingNumberController.text =
        widget.profileModel.buildingNumber ?? '';
    profile.profileUserNameController.text = widget.profileModel.userName ?? '';
    profile.profileEmailController.text = widget.profileModel.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final profileProvider = ProfileProvider.get(context);
    final auth = AuthProvider.get(context);

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
              body: auth.countryStatus == NetworkStatus.loading ||
                      profileProvider.getProfileStatus == NetworkStatus.loading
                  ? OpacityLoadingLogo()
                  : auth.countryStatus == NetworkStatus.success &&
                          profileProvider.getProfileStatus ==
                              NetworkStatus.success
                      ? _screen(profileProvider, context, demo, auth)
                      : RetryWidget(
                          retryCallback: () async {
                            await auth.getAllCountries(
                              retry: true,
                            );
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
              body: auth.countryStatus == NetworkStatus.loading ||
                      profileProvider.getProfileStatus == NetworkStatus.loading
                  ? OpacityLoadingLogo()
                  : auth.countryStatus == NetworkStatus.success &&
                          profileProvider.getProfileStatus ==
                              NetworkStatus.success
                      ? _screen(profileProvider, context, demo, auth)
                      : RetryWidget(
                          retryCallback: () async {
                            await auth.getAllCountries(
                              retry: true,
                            );
                            await profileProvider.getProfileData(
                              userId: Preferences.instance.getUserId,
                              retry: true,
                            );
                          },
                        ),
            ),
    );
  }

  Form _screen(ProfileProvider profileProvider, BuildContext context,
      DemoLocalization demo, AuthProvider auth) {
    return Form(
      key: _form,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: Preferences.instance.getUserImage == '' ||
                        profileProvider.selectedProfileImage != null
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
                      image: profileProvider.selectedProfileImage != null
                          ? Image.file(profileProvider.selectedProfileImage!)
                              .image
                          : Preferences.instance.getUserImage == ''
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
              InkWell(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    color: Colors.brown,
                  ),
                  child: MainText(
                    text: 'تعديل الصورة الشخصية',
                    color: Colors.white,
                    font: 12.sp,
                    weight: FontWeight.w700,
                  ),
                ),
                onTap: () async {
                  await profileProvider.pickImageFromGallary();
                  if (profileProvider.selectedProfileImage != null) {
                    print(
                      profileProvider.selectedProfileImage!.path,
                    );
                  }
                },
              ),
              SizedBox(height: 12.h),
              Container(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: profileProvider.profileUserNameController,
                      enable: false,
                      disableBorder: true,
                      hasHeader: true,
                      header: demo.getTranslatedValue('user_name'),
                      headerFont: 12.sp,
                      headerTextColor: Colors.black,
                      headerWeight: FontWeight.normal,
                      headerFamily: 'Lato',
                      type: TextInputType.text,
                      valid: (v) {
                        if (v!.isEmpty) {
                          return 'من فضلك ادخل اسم المستخدم';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: profileProvider.profileEmailController,
                      enable: false,
                      disableBorder: true,
                      hasHeader: true,
                      header: demo.getTranslatedValue('email'),
                      headerFont: 12.sp,
                      headerTextColor: Colors.black,
                      headerWeight: FontWeight.w400,
                      type: TextInputType.visiblePassword,
                      isPassword: false,
                      valid: (v) {
                        if (v!.isEmpty) {
                          return 'من فضلك ادخل اسم الايميل';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: profileProvider.profileFullNameController,
                      hasHeader: true,
                      header: 'الاسم الكامل',
                      headerFont: 12.sp,
                      headerWeight: FontWeight.w400,
                      headerTextColor: Colors.black,
                      type: TextInputType.visiblePassword,
                      isPassword: false,
                      valid: (v) {
                        if (v!.isEmpty) {
                          return 'من فضلك ادخل الاسم الكامل الخاص بك';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: profileProvider.profileMobileNumberController,
                      maxLength: 10,
                      hasHeader: true,
                      header: demo.getTranslatedValue('mobile_number'),
                      headerFont: 12.sp,
                      headerWeight: FontWeight.w400,
                      headerTextColor: Colors.black,
                      type: TextInputType.number,
                      isPassword: false,
                      valid: (String? v) {
                        if (v!.isEmpty) {
                          return 'من فضلك ادخل رقم المحمول';
                        }
                        final n = num.tryParse(v);
                        if (n == null || v.length != 10) {
                          return 'رقم المحمول يتكون من 10 ارقام';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: profileProvider.profileFixedNumberController,
                      maxLength: 7,
                      hasHeader: true,
                      header: demo.getTranslatedValue('fixed_number'),
                      headerFont: 12.sp,
                      headerTextColor: Colors.black,
                      headerWeight: FontWeight.w400,
                      type: TextInputType.number,
                      isPassword: false,
                      valid: (String? v) {
                        if (v!.isEmpty) {
                          return 'من فضلك ادخل الرقم الثابت';
                        }
                        final n = num.tryParse(v);
                        if (n == null || v.length != 7) {
                          return 'الرقم الثابت يتكون من 7 ارقام';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),

                    // CustomTextField(
                    //   controller:
                    //       profileProvider.profileCompanyName_ArController,
                    //   hasHeader: true,
                    //   header: demo.getTranslatedValue('company_name_in_ar'),
                    //   hasHint: true,
                    //   headerFont: 12.sp,
                    //   hintFont: 12.sp,
                    //   hintColor: Colors.grey,
                    //   headerTextColor: Colors.black,
                    //   headerWeight: FontWeight.w400,
                    //   type: TextInputType.text,
                    //   valid: (v) {
                    //     if (v!.isEmpty) {
                    //       return 'من فضلك ادخل اسم الشركة باللغة العربية';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),

                    // SizedBox(height: 10.h),

                    // CustomTextField(
                    //   controller:
                    //       profileProvider.profileCompanyName_EnController,
                    //   hasHint: true,
                    //   hasHeader: true,
                    //   header: demo.getTranslatedValue('company_name_in_en'),
                    //   headerFont: 12.sp,
                    //   headerTextColor: Colors.black,
                    //   headerWeight: FontWeight.w400,
                    //   type: TextInputType.name,
                    //   isPassword: false,
                    //   valid: (v) {
                    //     if (v!.isEmpty) {
                    //       return 'من فضلك ادخل اسم الشركة باللغة الانجليزية';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),

                    // SizedBox(height: 10.h),

                    // CustomTextField(
                    //   controller: profileProvider.profileTaxNumberController,
                    //   hasHint: false,
                    //   hasHeader: true,
                    //   header: demo.getTranslatedValue('tax_number'),
                    //   headerFont: 12.sp,
                    //   headerTextColor: Colors.black,
                    //   headerWeight: FontWeight.w400,
                    //   type: TextInputType.visiblePassword,
                    //   isPassword: false,
                    //   valid: (String? v) {
                    //     if (v!.isEmpty) {
                    //       return null;
                    //     }
                    //     final n = num.tryParse(v);
                    //     if (n == null) {
                    //       return 'من فضلك ادخل رقم ضريبي صحيح';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    // SizedBox(height: 10.h),

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     /////COUNTRY///////
                    //     Container(
                    //       margin: EdgeInsets.only(right: 10.w),
                    //       child: MainText(
                    //         text: 'الدولة',
                    //         font: 12.sp,
                    //         color: Colors.black,
                    //         weight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     DropMenu(
                    //       hint: firstCountry
                    //           ? widget.profileModel.country!
                    //           : 'اختر الدولة',
                    //       items: auth.allCountries
                    //           .where((e) => e.cities!.isNotEmpty)
                    //           .map((e) => e.countryName!)
                    //           .toList(),
                    //       value: selectedCountryValue,
                    //       onChanged: (v) {
                    //         firstCountry = false;
                    //         setState(
                    //           () {
                    //             selectedCityValue = null;
                    //             selectedStateValue = null;
                    //             selectedCountry = auth.allCountries
                    //                 .where((e) => (v == e.countryName!))
                    //                 .toList()[0];
                    //             selectedCountryValue = v!;
                    //             print('Country > ${selectedCountry!.id}');
                    //             print('Country > ${selectedCountryValue}');
                    //           },
                    //         );
                    //       },
                    //       valid: (v) {
                    //         if (v == null && !firstCountry) {
                    //           return 'من فضلك اختر الدولة';
                    //         }
                    //         return null;
                    //       },
                    //     ),
                    //     SizedBox(
                    //       height: 10.h
                    //     ),
                    //     /////CITY///////
                    //     Container(
                    //       margin: EdgeInsets.only(right: 10.w),
                    //       child: MainText(
                    //         text: 'المدينة',
                    //         font: 12.sp,
                    //         color: Colors.black,
                    //         weight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     DropMenu(
                    //       hint: firstCountry
                    //           ? widget.profileModel.city!
                    //           : 'اختر المدينة',
                    //       items: selectedCountry != null
                    //           ? selectedCountry!.cities!
                    //               .map((e) => e.cityName!)
                    //               .toList()
                    //           : [],
                    //       value: selectedCityValue,
                    //       onChanged: (v) {
                    //         selectedStateValue = null;
                    //         firstCountry = false;
                    //         setState(() {
                    //           selectedCity = selectedCountry!.cities!
                    //               .where((e) => (v == e.cityName!))
                    //               .toList()[0];
                    //           selectedCityValue = v!;
                    //           print('City > ${selectedCity!.id}');
                    //           print('City > ${selectedCityValue}');
                    //         });
                    //       },
                    //       valid: (v) {
                    //         if (v == null && !firstCountry) {
                    //           return 'من فضلك اختر المدينة';
                    //         } else
                    //           return null;
                    //       },
                    //     ),
                    //     /////STATE///////
                    //     Container(
                    //       margin: EdgeInsets.only(right: 10.w),
                    //       child: MainText(
                    //         text: 'المنطقة',
                    //         font: 12.sp,
                    //         color: Colors.black,
                    //         weight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     DropMenu(
                    //       hint: firstCountry
                    //           ? widget.profileModel.state!
                    //           : 'اختر المنطقة',
                    //       items: selectedCity != null
                    //           ? selectedCity!.states!
                    //               .map((e) => e.stateName!)
                    //               .toList()
                    //           : [],
                    //       value: selectedStateValue,
                    //       onChanged: (v) {
                    //         firstCountry = false;
                    //         setState(() {
                    //           selectedState = selectedCity!.states!
                    //               .where((e) => (v == e.stateName!))
                    //               .toList()[0];
                    //           selectedStateValue = v!;
                    //           print('State > ${selectedState!.id}');
                    //           print('State > ${selectedStateValue}');
                    //         });
                    //       },
                    //       valid: (v) {
                    //         if (v == null && !firstCountry) {
                    //           return 'من فضلك اختر المنطقة';
                    //         } else
                    //           return null;
                    //       },
                    //     ),
                    //     SizedBox(
                    //       height: 10.h
                    //     ),
                    //     CustomTextField(
                    //       controller: profileProvider.profileStreetController,
                    //       hasHint: false,
                    //       hasHeader: true,
                    //       header: demo.getTranslatedValue('street_name'),
                    //       headerFont: 12.sp,
                    //       headerWeight: FontWeight.w400,
                    //       headerTextColor: Colors.black,
                    //       type: TextInputType.visiblePassword,
                    //       isPassword: false,
                    //       // valid: (v) {
                    //       //   if (v!.isEmpty) {
                    //       //     return 'من فضلك ادخل اسم الشارع';
                    //       //   } else {
                    //       //     return null;
                    //       //   }
                    //       // },
                    //     ),
                    //     SizedBox(height: 10.h),
                    //     CustomTextField(
                    //       controller:
                    //           profileProvider.profileBuildingNumberController,
                    //       hasHint: false,
                    //       hasHeader: true,
                    //       header: demo.getTranslatedValue(
                    //           'building_architecture_villa_number'),
                    //       headerFont: 12.sp,
                    //       headerTextColor: Colors.black,
                    //       headerWeight: FontWeight.w400,
                    //       type: TextInputType.visiblePassword,
                    //       isPassword: false,
                    //       valid: (String? v) {
                    //         if (v!.isEmpty) {
                    //           return null;
                    //         }
                    //         final n = num.tryParse(v);
                    //         if (n == null) {
                    //           return 'من فضلك ادخل رقم المبني';
                    //         }
                    //         return null;
                    //       },
                    //     ),
                    //     SizedBox(height: 10.h),
                    //   ],
                    // ),
                  ],
                ),
              ),
              CustomButton(
                title: demo.getTranslatedValue('next'),
                color: kSecondaryColor,
                height: 50.h,
                textColor: Colors.white,
                family: 'Lato_smiBold',
                onPressed: () async {
                  if (_form.currentState!.validate()) {
                    await profileProvider.editProdile(
                      UserId: Preferences.instance.getUserId,
                      FullName: profileProvider.profileFullNameController.text,
                      MobileNumber:
                          profileProvider.profileMobileNumberController.text,
                      FixedNumber:
                          profileProvider.profileFixedNumberController.text,
                      CompanyName_En:
                          profileProvider.profileCompanyName_EnController.text,
                      CompanyName_Ar:
                          profileProvider.profileCompanyName_ArController.text,
                      TaxNumber:
                          profileProvider.profileTaxNumberController.text,
                      Image: profileProvider.selectedProfileImage,
                      CountryId: firstCountry
                          ? widget.profileModel.countryId!
                          : selectedCountry!.id!,
                      CityId: firstCountry
                          ? widget.profileModel.cityId!
                          : selectedCity!.id!,
                      StateId: firstCountry
                          ? widget.profileModel.stateId!
                          : selectedState!.id!,
                      Street: profileProvider.profileStreetController.text,
                      BuildingNumber:
                          profileProvider.profileBuildingNumberController.text,
                      UserName: profileProvider.profileUserNameController.text,
                      Email: profileProvider.profileEmailController.text,
                      sameMobile:
                          profileProvider.profileMobileNumberController.text ==
                              widget.profileModel.mobileNumber,
                    );
                  }
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
