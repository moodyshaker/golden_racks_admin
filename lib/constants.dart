import 'dart:io';
import 'dart:ui';

import 'package:flutter/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:golden_racks_admin/feature/admin/auth_screens/organizer_login.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/requests_screen/maintainance_for_subscribers.dart';

import 'core/localization/demo_localization.dart';
import 'core/models/more_model.dart';
import 'core/models/nav_item.dart';
import 'core/router/router.dart';
import 'feature/admin/main_screens/requests_screen/activate_plane_screen.dart';
import 'feature/admin/main_screens/requests_screen/subscribers_emergency_requests_screen.dart';
import 'feature/admin/main_screens/requests_screen/subscribers_periodic_requests_screen.dart';
import 'feature/admin/main_screens/requests_screen/unsubscribers_periodic_requests_screen.dart';
import 'feature/admin/other_screens/add_company_with_plan_screen.dart';
import 'feature/admin/other_screens/add_spare_part_screen.dart';
import 'feature/admin/other_screens/create_plan_screen.dart';
import 'feature/admin/other_screens/share_company_data_screen.dart';
import 'feature/admin/other_screens/show_plans_screen.dart';
import 'feature/admin/other_screens/technician_view_screen.dart';
import 'feature/technician/main_screens/requests_screen/unsubscribers_emergency_requests_screen.dart';

String getAsset(String imageName) => 'assets/images/$imageName.png';

String getLottie(String name) => 'assets/images/$name.json';

const Color kMainColor = Color(0xFF098E4D);
const Color kSecondaryColor = Color(0xFF846046);
const Color kMainLighterColor = Color(0xFF8FC742);
const Color kLightGreenColor = Color(0xFF29CA8C);
const Color kPrimaryColor = Color(0xFFF68A1E);
const Color kAccentColor = Color(0xFFFFFFFF);
const Color kBackgroundColor = Color(0xFFE5E5E5);
const Color kChatGreyColor = Color(0xFFf2f4f5);
const Color kEventItemColor = Color(0xFFE9E9E9);
const Color kInactiveColor = Color(0xFFD3D3D3);
const Color kOffWihteColor = Color(0xFFD3D3D3);
const Color kOffWihteColor2 = Color(0xFFF9F9F9);
const Color kGreyColor = Color(0xFFD9D9D9);
const Color kBorderColor = Color(0xFFA8A89D);
const Color kDarkColor = Color(0xFF767676);
const Color kRedColor = Color(0xFFD31027);
const Color kGreenColor = Color(0xFF7FC823);
const Color kChatGreen = Color(0xFFCFF3E2);
const Color kWhiteBlueColor = Color(0xFFECECFD);
const Color kYellowColor = Color(0xFFF8D913);
const Color kBlackColor = Color(0xFF000000);
const Color kTitleColor = Color(0xFF7C7C7C);
const Color kStatusColor = Color(0xFF8FC742);
const Color kButtonColor = Color(0xFFD9D9D9);

const Color kWithOpacity = Color(0x80FFFFFF);

const Color mainColor = Color(0xFF846046);
const Color orangeColor = Color(0xFFFDBC1F);
const Color gray_80 = Color(0xFF3A3A3A);
const Color gray_60 = Color(0xFFA6A6AA);
const Color gray_40 = Color(0xFFCBCBD4);
const Color gray_20 = Color(0xFFF8F7FA);
const Color gray_10 = Color(0xFFE8ECF4);
const Color gray_0 = Color(0xFFF7F8F9);
const Color blueColor = Color(0xFF0082A2);
const Color lightBlueColor = Color(0xFF35C2C1);
const Color redColor = Color(0xFFFE8668);
const Color titleColor = Color(0xFF2D2D2D);
const Color backColor = Color(0xFFE2E2E2);

void closeKeyboard() => FocusScope.of(MagicRouter.currentContext!).unfocus();

void removeFocus(BuildContext ctx) => FocusScope.of(ctx).unfocus();

TextTheme get getTextTheme => Theme.of(MagicRouter.currentContext!).textTheme;

List<String> imagePickerList(BuildContext ctx) => ['Camera', 'Gallery'];

const List<String> cat = [
  'all',
  'conferences',
  'show',
  'workshop',
];

const List<String> status = [
  'in_progress',
  'confirmed',
  'rejected',
];

List<CategoryTest> cats = [
  CategoryTest(name: 'التنمية البشرية', image: '1'),
  CategoryTest(name: 'الطب', image: '2'),
  CategoryTest(name: 'القانون', image: '3'),
  CategoryTest(name: 'بشرة وجمال', image: '4'),
  CategoryTest(name: 'تكنولوجيا', image: '5'),
  CategoryTest(name: 'ريادة أعمال', image: '6'),
  CategoryTest(name: 'سياحة', image: '7'),
  CategoryTest(name: 'صحة ورياضة', image: '8'),
  CategoryTest(name: 'علوم', image: '9'),
  CategoryTest(name: 'فن وترفيه', image: '10'),
];

const List<String> genders = [
  'male',
  'female',
];

class CategoryTest {
  final String image;
  final String name;

  CategoryTest({required this.image, required this.name});
}


List<NavItem> navItems = [
  NavItem(icon: 'home_icon', title: 'القائمة'),
  NavItem(icon: 'icon', title: ''),
  NavItem(icon: 'add_new_icon', title: ''),
  NavItem(icon: 'ticket_icon', title: 'التذاكر'),
  NavItem(icon: 'control_icon', title: 'اللوحة'),
];

List<NavItem> organizerNavItems = [
  NavItem(icon: 'home_icon', title: 'القائمة'),
  NavItem(icon: 'icon', title: 'الإحصائيات'),
  NavItem(icon: 'add_new_icon', title: ''),
  NavItem(icon: 'ticket_icon', title: 'التذاكر'),
  NavItem(icon: 'control_icon', title: 'اللوحة'),
];

List<NavItem> technicianNavItems = [
  NavItem(icon: 'home_icon', title: 'القائمة'),
  NavItem(icon: 'ticket_icon', title: 'التذاكر'),
  NavItem(icon: 'control_icon', title: 'اللوحة'),
];

class DrawerItemModel {
  String title;
  String? count;
  Widget? route;

  DrawerItemModel({required this.title, this.count, this.route});
}

List<DrawerItemModel> list = [
  DrawerItemModel(
      title: 'تحديد فني لطلبات الطوارئ لغير المشتركين',
      count: '2',
      route: UnSubscribersEmergencyRequestsScreen()),
  DrawerItemModel(
      title: 'تحديد فني لطلبات الدورية لغير المشتركين',
      count: '5',
      route: UnSubscribersPeriodicRequestsScreen()),
  DrawerItemModel(
      title: 'تحديد فني لطلبات الطوارئ للمشتركين',
      count: '7',
      route: SubscribersEmergencyRequestsScreen()),
  DrawerItemModel(
      title: 'تحديد فني للصيانة الدورية للمشتركين',
      count: '8',
      route: MaintenanceForSubscribers()),
  DrawerItemModel(
      count: '3',
      title: 'حسابات في انتظار تفعيل الخطط لها', route: ActivatePlanScreen()),
  DrawerItemModel(
      title: 'انشاء حسابات الدخول للفنين', route: TechnicianViewScreen()),
  DrawerItemModel(
      title: 'انشاء حسابات للشركات وربطها بخطة',
      route: AddCompanyWithPlanScreen()),
  DrawerItemModel(
      title: 'بيانات الشركات المشتركة في خطط',
      route: SharedCompanyDataScreen()),
  DrawerItemModel(title: 'اضافة قطع الغيار', route: AddASparePartScreen()),
  DrawerItemModel(title: 'انشاء خطط الصيانة', route: CreatePlanScreen()),
  DrawerItemModel(title: 'التقارير'),
];

List<MoreModel> moreList(DemoLocalization demo) => [
      MoreModel(
          name: demo.getTranslatedValue('more_privacy_policy'), route: null),
      // PrivacyPolicy()
      MoreModel(
          name: demo.getTranslatedValue('more_previous_event'), route: null),
      MoreModel(name: demo.getTranslatedValue('more_bills'), route: null),
      MoreModel(name: demo.getTranslatedValue('more_faq'), route: null),
      MoreModel(
          name: demo.getTranslatedValue('more_language'),
          route: null,
          hasRoute: false,
          desc: 'lang'),
      MoreModel(name: demo.getTranslatedValue('more_rate_app'), route: null),
      MoreModel(name: demo.getTranslatedValue('more_ask'), route: null),
      MoreModel(
          name: demo.getTranslatedValue('more_logout'),
          route: null,
          hasRoute: false,
          desc: 'logout'),
    ];

const List<String> eventStatus = [
  'current_events',
  'upcoming_events',
  'previous_events',
];

const List<String> mainCategories = [
  'conferences',
  'show',
  'workshop',
];

// Future<File> compressFile(String path) async {
//   var splited = path.split('/');
//   String original = path
//       .split('/')
//       .last
//       .split('.')
//       .first;
//   String extension = path
//       .split('/')
//       .last
//       .split('.')
//       .last;
//   String outputName =
//       '${splited.sublist(0, splited.length - 1).join(
//       '/')}/${original}_out.$extension';
//   File? compressedFile = (await FlutterImageCompress.compressAndGetFile(
//     path,
//     outputName,
//     quality: 50,
//   )) as File?;
//   return compressedFile!;
// }
