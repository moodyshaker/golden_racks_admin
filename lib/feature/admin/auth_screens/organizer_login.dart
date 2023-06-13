import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/widgets/drop_menu.dart';
import '../../../constants.dart';
import '../../../core/bloc/organizer_app_cubit.dart';
import '../../../core/localization/demo_localization.dart';
import '../../../core/router/router.dart';
import '../../../core/validate/validation.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/main_text.dart';

class OrganizerLogin extends StatefulWidget {
  const OrganizerLogin({Key? key}) : super(key: key);

  @override
  State<OrganizerLogin> createState() => _OrganizerLoginState();
}

class _OrganizerLoginState extends State<OrganizerLogin> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool isPhone = false;

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final organizer = OrganizerAppCubit.get(context);
    List<String> type = ['مدير التطبيق' , 'فني'];
    return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(getAsset('background')),
              fit: BoxFit.fill,
            ),
          ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                            ),
                            child: Image.asset(getAsset('logo'),
                            width: double.infinity,
                            height: 141.h,
                            fit: BoxFit.cover,),
                          ),
                          SizedBox(height: 4.h,),
                          DropMenu(
                            hint: 'مدير التطبيق',
                            items: type,
                            onChanged: (v){

                            },
                          ),
                          CustomTextField(
                            controller: organizer.loginEmailController,
                            hasHeader: true,
                            header: 'user name',
                            hasHint: false,
                            headerFont: 12.sp,
                            headerTextColor: Colors.black,
                            headerWeight: FontWeight.w400,
                            headerFamily: 'Lato_regular',
                            type: TextInputType.text,
                            valid: (String? v) {

                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomTextField(
                            controller: organizer.loginPasswordController,
                            hasHint: false,
                            hasHeader: true,
                            header: 'password',
                            headerFont: 12.sp,
                            headerTextColor: Colors.black,
                            headerWeight: FontWeight.w400,
                            headerFamily: 'Lato_regular',
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                            valid: (String? v) => v!.isEmpty
                                ? demo.getTranslatedValue('password_validation')
                                : v.length < 8
                                    ? demo.getTranslatedValue(
                                        'password_8ch_validation')
                                    : Validations.passwordVerified(v)
                                        ? null
                                        : demo.getTranslatedValue(
                                            'strong_password'),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomButton(
                            title: 'login',
                            color: kSecondaryColor,
                            height: 50.h,
                            font: 16.sp,
                            family: 'Lato_bold',
                            textColor: Colors.white,
                            withBorder: false,
                            onPressed: () async {

                            },
                          ),
                          SizedBox(height: 25.h,),
                          GestureDetector(
                            onTap: (){

                            },
                            child: MainText(
                              text: 'rest pass',
                              font: 14.sp,
                              color: gray_80,
                              weight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 105.h,
                          ),
                          CustomButton(
                            title: 'register',
                            color: Colors.transparent,
                            height: 60.h,
                            font: 20.sp,
                            family: 'Lato_smiBold',
                            textColor: Colors.black,
                            borderColor: Colors.black,
                            onPressed: () async {

                            },
                          ),
                          SizedBox(height: 10.h,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
